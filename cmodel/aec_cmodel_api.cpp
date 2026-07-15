#include "aec_cmodel_api.h"

#include <Python.h>
#include <algorithm>
#include <sstream>

namespace {
uint32_t hex32(PyObject* object) {
  const char* text = PyUnicode_AsUTF8(object);
  return text ? static_cast<uint32_t>(std::stoul(text, nullptr, 16)) : 0;
}
uint32_t u32(PyObject* object) { return static_cast<uint32_t>(PyLong_AsUnsignedLong(object)); }

std::vector<AecCmodelWrite> parse_writes(PyObject* event, const char* field, bool predicate) {
  std::vector<AecCmodelWrite> out;
  PyObject* writes = PyDict_GetItemString(event, field);
  for (Py_ssize_t i = 0; writes && i < PyList_Size(writes); ++i) {
    PyObject* item = PyList_GetItem(writes, i);
    AecCmodelWrite write{};
    write.lane = static_cast<uint8_t>(u32(PyDict_GetItemString(item, "lane")));
    write.index = static_cast<uint16_t>(u32(PyDict_GetItemString(item, predicate ? "pred" : "reg")));
    write.value = predicate ? (PyObject_IsTrue(PyDict_GetItemString(item, "value")) ? 1u : 0u)
                            : hex32(PyDict_GetItemString(item, "value"));
    out.push_back(write);
  }
  return out;
}
}

AecCmodelApi::AecCmodelApi(const std::string& repo_root, const std::string& program,
                           uint32_t instructions, const std::array<uint32_t, 3>& grid,
                           const std::array<uint32_t, 3>& block, uint64_t max_steps,
                           const std::vector<AecCmodelInit>& init, size_t gmem_bytes) {
  if (!Py_IsInitialized()) Py_Initialize();
  PyObject* path = PySys_GetObject("path");
  PyObject* root = PyUnicode_FromString(repo_root.c_str());
  PyList_Insert(path, 0, root); Py_DECREF(root);
  PyObject* module = PyImport_ImportModule("cmodel.capi");
  if (!module) { PyErr_Print(); error_ = "cannot import cmodel.capi"; return; }
  PyObject* function = PyObject_GetAttrString(module, "build_reference");
  PyObject* py_grid = Py_BuildValue("(III)", grid[0], grid[1], grid[2]);
  PyObject* py_block = Py_BuildValue("(III)", block[0], block[1], block[2]);
  PyObject* py_init = PyList_New(init.size());
  for (size_t i = 0; i < init.size(); ++i) {
    PyObject* bytes = PyBytes_FromStringAndSize(reinterpret_cast<const char*>(init[i].data.data()), init[i].data.size());
    PyObject* entry = Py_BuildValue("(IIO)", init[i].target, init[i].address, bytes);
    Py_DECREF(bytes); PyList_SET_ITEM(py_init, i, entry);
  }
  PyObject* args = Py_BuildValue("(sIOOKOn)", program.c_str(), instructions, py_grid, py_block,
                                 static_cast<unsigned long long>(max_steps), py_init,
                                 static_cast<Py_ssize_t>(gmem_bytes));
  Py_DECREF(py_grid); Py_DECREF(py_block); Py_DECREF(py_init);
  PyObject* result = PyObject_CallObject(function, args);
  Py_DECREF(args); Py_DECREF(function); Py_DECREF(module);
  if (!result) { PyErr_Print(); error_ = "CModel reference execution failed"; return; }
  status_ = PyUnicode_AsUTF8(PyDict_GetItemString(result, "status"));
  detail_ = PyUnicode_AsUTF8(PyDict_GetItemString(result, "detail"));
  PyObject* memory = PyDict_GetItemString(result, "gmem");
  char* memory_data = nullptr; Py_ssize_t memory_size = 0;
  if (PyBytes_AsStringAndSize(memory, &memory_data, &memory_size) == 0)
    gmem_.assign(memory_data, memory_data + memory_size);
  PyObject* groups = PyDict_GetItemString(result, "events");
  PyObject *key, *value; Py_ssize_t pos = 0;
  while (PyDict_Next(groups, &pos, &key, &value)) {
    Key parsed{u32(PyTuple_GetItem(key, 0)), u32(PyTuple_GetItem(key, 1)),
               u32(PyTuple_GetItem(key, 2)), static_cast<uint8_t>(u32(PyTuple_GetItem(key, 3)))};
    auto& destination = events_[parsed];
    for (Py_ssize_t i = 0; i < PyList_Size(value); ++i) {
      PyObject* source = PyList_GetItem(value, i); AecCmodelEvent event;
      event.pc = u32(PyDict_GetItemString(source, "pc"));
      event.instruction = PyUnicode_AsUTF8(PyDict_GetItemString(source, "instruction"));
      event.execute_mask = hex32(PyDict_GetItemString(source, "execute_mask"));
      event.gpr_writes = parse_writes(source, "gpr_writes", false);
      event.predicate_writes = parse_writes(source, "predicate_writes", true);
      destination.push_back(std::move(event));
    }
  }
  Py_DECREF(result);
}

AecCmodelApi::~AecCmodelApi() = default;

bool AecCmodelApi::pop(const Key& key, AecCmodelEvent& event) {
  auto found = events_.find(key); size_t& index = cursor_[key];
  if (found == events_.end() || index >= found->second.size()) return false;
  event = found->second[index++]; return true;
}

size_t AecCmodelApi::remaining() const {
  size_t count = 0;
  for (const auto& [key, events] : events_) {
    auto found = cursor_.find(key); const size_t used = found == cursor_.end() ? 0 : found->second;
    count += events.size() - std::min(events.size(), used);
  }
  return count;
}

#pragma once

#include <array>
#include <cstdint>
#include <map>
#include <string>
#include <tuple>
#include <vector>

struct AecCmodelInit {
  uint32_t target;
  uint32_t address;
  std::vector<uint8_t> data;
};

struct AecCmodelWrite {
  uint8_t lane;
  uint16_t index;
  uint32_t value;
};

struct AecCmodelEvent {
  uint32_t pc = 0;
  std::string instruction;
  uint32_t execute_mask = 0;
  std::vector<AecCmodelWrite> gpr_writes;
  std::vector<AecCmodelWrite> predicate_writes;
};

class AecCmodelApi {
 public:
  using Key = std::tuple<uint32_t, uint32_t, uint32_t, uint8_t>;

  AecCmodelApi(const std::string& repo_root, const std::string& program,
               uint32_t program_instructions, const std::array<uint32_t, 3>& grid,
               const std::array<uint32_t, 3>& block, uint64_t max_steps,
               const std::vector<AecCmodelInit>& init, size_t gmem_bytes);
  ~AecCmodelApi();
  AecCmodelApi(const AecCmodelApi&) = delete;
  AecCmodelApi& operator=(const AecCmodelApi&) = delete;

  bool ok() const { return error_.empty(); }
  const std::string& error() const { return error_; }
  const std::string& status() const { return status_; }
  const std::string& detail() const { return detail_; }
  const std::vector<uint8_t>& gmem() const { return gmem_; }
  bool pop(const Key& key, AecCmodelEvent& event);
  size_t remaining() const;

 private:
  std::string error_, status_, detail_;
  std::vector<uint8_t> gmem_;
  std::map<Key, std::vector<AecCmodelEvent>> events_;
  std::map<Key, size_t> cursor_;
};

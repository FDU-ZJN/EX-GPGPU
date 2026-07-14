"""Dependency-free testcase manifest adapter."""
from __future__ import annotations
import ast,json,re
from pathlib import Path
from .execution import create_gpu
MEMORY_TARGETS=('gmem','pmem','cmem')
LOCAL_CAPACITY_LIMIT=65536
def load_yaml(path):
 d={}; cur=None
 for raw in Path(path).read_text().splitlines():
  if not raw.strip() or raw.lstrip().startswith('#'):continue
  indent=len(raw)-len(raw.lstrip()); line=raw.strip()
  if indent==0 and ':' in line:
   k,v=line.split(':',1);cur=k;d[k]=parse(v.strip()) if v.strip() else ([] if k=='memory_init' else {})
  elif line.startswith('- ') and not isinstance(cur,tuple):d[cur].append(parse_item(line[2:]))
  elif indent and ':' in line and isinstance(d.get(cur),dict):
   k,v=line.split(':',1); d[cur][k.strip()]=parse(v.strip()) if v.strip() else []; cur=(cur,k.strip()) if k.strip()=='memory' else cur
  elif line.startswith('- ') and isinstance(cur,tuple):
   d[cur[0]][cur[1]].append(parse_item(line[2:]))
  elif isinstance(cur,tuple) and ':' in line:
   k,v=line.split(':',1)
   if k.strip() in ('comparison',): d[cur[0]][k.strip()]=parse(v.strip()); cur=cur[0]
   else: d[cur[0]][cur[1]][-1][k.strip()]=parse(v.strip())
  elif indent and ':' in line and isinstance(d.get(cur),list):
   k,v=line.split(':',1);d[cur][-1][k.strip()]=parse(v.strip())
 return d
def parse(v):
 if not v:return None
 if v in ('[]','{}'):return ast.literal_eval(v)
 if v.startswith('{'):
  return {k.strip():parse(x.strip()) for k,x in re.findall(r'([\w_]+):\s*(\[[^]]*\]|[^,}]+)',v)}
 if v.startswith('[') and '{' in v:
  return [parse(v[1:-1])]
 if v.startswith('['):return [parse(x.strip()) for x in v[1:-1].split(',')]
 try:return int(v,0)
 except ValueError:
  try:return float(v)
  except ValueError:return v.strip('"\'')
def parse_item(v):
 k,x=v.split(':',1);return {k.strip():parse(x.strip())}
def derive_capacities(case, manifest):
 case=Path(case); capacity={name:0 for name in MEMORY_TARGETS}; init_capacity={name:0 for name in MEMORY_TARGETS}
 for item in manifest.get('memory_init',[]):
  target=item.get('target','gmem')
  if target not in capacity: raise ValueError(f'unsupported memory target {target!r}')
  payload=(case.parent/item['file']).read_bytes(); declared=item.get('size')
  if declared is not None and declared != len(payload):
   raise ValueError(f"artifact size mismatch for {item['file']}: declared={declared} actual={len(payload)}")
  end=item['address']+len(payload)
  if item['address'] < 0 or end > (1<<32): raise ValueError(f'memory artifact exceeds 32-bit address space: {item}')
  init_capacity[target]=max(init_capacity[target],end); capacity[target]=max(capacity[target],end)
 for item in manifest.get('expected',{}).get('memory',[]):
  target=item.get('target','gmem')
  if target not in capacity: raise ValueError(f'unsupported expected memory target {target!r}')
  expected=(case.parent/item['file']).read_bytes()
  if len(expected) != item['size']:
   raise ValueError(f"expected size mismatch for {item['file']}: declared={item['size']} actual={len(expected)}")
  end=item['address']+item['size']
  if item['address'] < 0 or end > (1<<32): raise ValueError(f'expected artifact exceeds 32-bit address space: {item}')
  if target != 'gmem' and end > init_capacity[target]:
   raise ValueError(f'expected-only {target} capacity requires an official capacity channel')
  capacity[target]=max(capacity[target],end)
 for target in ('cmem','pmem'):
  if capacity[target] > LOCAL_CAPACITY_LIMIT: raise ValueError(f'{target} capacity exceeds 64 KiB implementation limit')
 return capacity
def run_case(case,out,trace_path=None):
 case=Path(case);m=load_yaml(case);out=Path(out);out.mkdir(parents=True,exist_ok=True)
 capacities=derive_capacities(case,m)
 images={name:bytearray(capacities[name]) for name in MEMORY_TARGETS}
 for x in m.get('memory_init',[]):
  data=(case.parent/x['file']).read_bytes(); target=x.get('target','gmem')
  end=x['address']+len(data); images[target][x['address']:end]=data
 l=m['launch']
 trace_file = open(trace_path, 'w', encoding='utf-8') if trace_path else None
 try:
  gpu=create_gpu(case.parent/m['program'],tuple(l['grid']),tuple(l['block']),program_instructions=l.get('program_instructions'),gmem=images['gmem'],cmem=images['cmem'],pmem=images['pmem'],trace=trace_file);r=gpu.run(m.get('max_cycles',100000))
 finally:
  if trace_file: trace_file.close()
 result={'status':str(r.status).replace('exec_error','fail'),'instruction_steps':r.instruction_steps,'completed_ctas':r.completed_ctas,'error_detail':r.error_detail};(out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
 for x in m.get('expected',{}).get('memory',[]):
  target=x.get('target','gmem'); (out/f"{target}_{x['address']:016x}.bin").write_bytes(images[target][x['address']:x['address']+x['size']])
 return result

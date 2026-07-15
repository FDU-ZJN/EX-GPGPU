"""Dependency-free testcase manifest adapter."""
from __future__ import annotations
import ast,json,re
from pathlib import Path
from .execution import create_gpu
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
def run_case(case,out,trace_path=None):
 case=Path(case);m=load_yaml(case);out=Path(out);out.mkdir(parents=True,exist_ok=True)
 images={'gmem':bytearray(), 'cmem':bytearray(), 'pmem':bytearray()}
 for x in m.get('memory_init',[]):
  data=(case.parent/x['file']).read_bytes(); target=x.get('target') or ('cmem' if 'cmem' in x['file'] else 'pmem' if 'pmem' in x['file'] else 'gmem')
  if target not in images: raise ValueError(f'unsupported memory target {target!r}')
  end=x['address']+len(data); images[target].extend(b'\0'*max(0,end-len(images[target]))); images[target][x['address']:end]=data
 # GMEM must also cover all requested dumps; a no-input GMEM remains a useful
 # 1 MiB functional backing store for binaries that address ordinary buffers.
 dump_end=max((x['address']+x['size'] for x in m.get('expected',{}).get('memory',[])),default=0)
 images['gmem'].extend(b'\0'*max(0,max(1<<20,dump_end)-len(images['gmem'])))
 l=m['launch']
 trace_file = open(trace_path, 'w', encoding='utf-8') if trace_path else None
 try:
  gpu=create_gpu(case.parent/m['program'],tuple(l['grid']),tuple(l['block']),program_instructions=l.get('program_instructions'),gmem=images['gmem'],cmem=images['cmem'],pmem=images['pmem'],trace=trace_file);r=gpu.run(m.get('max_cycles',100000))
 finally:
  if trace_file: trace_file.close()
 result={'status':str(r.status).replace('exec_error','fail'),'instruction_steps':r.instruction_steps,'completed_ctas':r.completed_ctas,'error_detail':r.error_detail};(out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
 for x in m.get('expected',{}).get('memory',[]):(out/f"gmem_{x['address']:016x}.bin").write_bytes(images['gmem'][x['address']:x['address']+x['size']])
 return result

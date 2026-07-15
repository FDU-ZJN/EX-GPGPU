// Exact contest-facing adapter for the generated core.
module aec_eval_top (
    input logic clk, input logic rst_n,
    input logic load_valid, output logic load_ready, input logic [2:0] load_target,
    input logic [31:0] load_addr, input logic [127:0] load_data, input logic [15:0] load_strb,
    input logic launch_valid, output logic launch_ready,
    input logic [31:0] grid_x, grid_y, grid_z, block_x, block_y, block_z, program_instructions,
    output logic result_valid, input logic result_ready, output logic [2:0] result_status, output logic [63:0] result_cycles,
    input logic read_valid, output logic read_ready, input logic [31:0] read_addr,
    output logic read_data_valid, output logic [127:0] read_data,
    output logic mem_req_valid, input logic mem_req_ready, output logic mem_req_space, output logic mem_req_write,
    output logic [31:0] mem_req_addr, output logic [1023:0] mem_req_wdata, output logic [127:0] mem_req_wstrb,
    output logic [3:0] mem_req_tag, input logic mem_rsp_valid, output logic mem_rsp_ready,
    input logic [1023:0] mem_rsp_rdata, input logic [3:0] mem_rsp_tag, input logic mem_rsp_error
);
  /* verilator lint_off PINMISSING */
  AecEvalCore u_core (
    .clock(clk), .reset(!rst_n),
    .io_load_valid(load_valid), .io_load_ready(load_ready), .io_load_target(load_target), .io_load_addr(load_addr), .io_load_data(load_data), .io_load_strb(load_strb),
    .io_launch_valid(launch_valid), .io_launch_ready(launch_ready), .io_grid_x(grid_x), .io_grid_y(grid_y), .io_grid_z(grid_z), .io_block_x(block_x), .io_block_y(block_y), .io_block_z(block_z), .io_program_instructions(program_instructions),
    .io_result_valid(result_valid), .io_result_ready(result_ready), .io_result_status(result_status), .io_result_cycles(result_cycles),
    .io_read_valid(read_valid), .io_read_ready(read_ready), .io_read_addr(read_addr), .io_read_data_valid(read_data_valid), .io_read_data(read_data),
    .io_mem_req_valid(mem_req_valid), .io_mem_req_ready(mem_req_ready), .io_mem_req_space(mem_req_space), .io_mem_req_write(mem_req_write), .io_mem_req_addr(mem_req_addr), .io_mem_req_wdata(mem_req_wdata), .io_mem_req_wstrb(mem_req_wstrb), .io_mem_req_tag(mem_req_tag),
    .io_mem_rsp_valid(mem_rsp_valid), .io_mem_rsp_ready(mem_rsp_ready), .io_mem_rsp_rdata(mem_rsp_rdata), .io_mem_rsp_tag(mem_rsp_tag), .io_mem_rsp_error(mem_rsp_error)
  );
  /* verilator lint_on PINMISSING */
endmodule

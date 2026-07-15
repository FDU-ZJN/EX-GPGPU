// Exact contest-facing adapter. Architectural state lives in generated
// AecEvalTop; debug retirement ports remain internal to this judged top.
module aec_eval_top (
    input logic clk, input logic rst_n,
    input logic load_valid, output logic load_ready, input logic [2:0] load_target,
    input logic [31:0] load_addr, input logic [127:0] load_data, input logic [15:0] load_strb,
    input logic launch_valid, output logic launch_ready,
    input logic [31:0] grid_x, grid_y, grid_z, block_x, block_y, block_z, program_instructions,
    output logic result_valid, input logic result_ready, output logic [2:0] result_status, output logic [63:0] result_cycles,
    input logic read_valid, output logic read_ready, input logic [31:0] read_addr,
    output logic read_data_valid, output logic [127:0] read_data,
    output logic mem_req_valid, input logic mem_req_ready, output logic mem_req_write,
    output logic [31:0] mem_req_addr, output logic [1023:0] mem_req_wdata, output logic [127:0] mem_req_wstrb,
    output logic [3:0] mem_req_tag, input logic mem_rsp_valid, output logic mem_rsp_ready,
    input logic [1023:0] mem_rsp_rdata, input logic [3:0] mem_rsp_tag, input logic mem_rsp_error
);
  /* verilator lint_off PINMISSING */
  AecEvalTop u_core (
    .clock(clk), .reset(!rst_n),
    .io_load_valid(load_valid), .io_load_ready(load_ready), .io_load_target(load_target), .io_load_addr(load_addr), .io_load_data(load_data), .io_load_strb(load_strb),
    .io_launch_valid(launch_valid), .io_launch_ready(launch_ready), .io_grid_x(grid_x), .io_grid_y(grid_y), .io_grid_z(grid_z), .io_block_x(block_x), .io_block_y(block_y), .io_block_z(block_z), .io_program_instructions(program_instructions),
    .io_result_valid(result_valid), .io_result_ready(result_ready), .io_result_status(result_status), .io_result_cycles(result_cycles),
    .io_read_valid(read_valid), .io_read_ready(read_ready), .io_read_addr(read_addr), .io_read_data_valid(read_data_valid), .io_read_data(read_data),
    .io_mem_req_valid(mem_req_valid), .io_mem_req_ready(mem_req_ready), .io_mem_req_write(mem_req_write), .io_mem_req_addr(mem_req_addr), .io_mem_req_wdata(mem_req_wdata), .io_mem_req_wstrb(mem_req_wstrb), .io_mem_req_tag(mem_req_tag),
    .io_mem_rsp_valid(mem_rsp_valid), .io_mem_rsp_ready(mem_rsp_ready), .io_mem_rsp_rdata(mem_rsp_rdata), .io_mem_rsp_tag(mem_rsp_tag), .io_mem_rsp_error(mem_rsp_error)
  );
  /* verilator lint_on PINMISSING */
endmodule

// Simulation-only wrapper exposing retirement events to the realtime
// differential harness. It is never selected as the judged/PPA top.
module aec_eval_debug_top (
    input logic clk, input logic rst_n,
    input logic load_valid, output logic load_ready, input logic [2:0] load_target,
    input logic [31:0] load_addr, input logic [127:0] load_data, input logic [15:0] load_strb,
    input logic launch_valid, output logic launch_ready,
    input logic [31:0] grid_x, grid_y, grid_z, block_x, block_y, block_z, program_instructions,
    output logic result_valid, input logic result_ready, output logic [2:0] result_status, output logic [63:0] result_cycles,
    input logic read_valid, output logic read_ready, input logic [31:0] read_addr,
    output logic read_data_valid, output logic [127:0] read_data,
    output logic mem_req_valid, input logic mem_req_ready, output logic mem_req_write,
    output logic [31:0] mem_req_addr, output logic [1023:0] mem_req_wdata, output logic [127:0] mem_req_wstrb,
    output logic [3:0] mem_req_tag, input logic mem_rsp_valid, output logic mem_rsp_ready,
    input logic [1023:0] mem_rsp_rdata, input logic [3:0] mem_rsp_tag, input logic mem_rsp_error
    ,output logic debug_commit_valid_0, debug_commit_valid_1, debug_commit_valid_2, debug_commit_valid_3
    ,output logic [31:0] debug_commit_cta_x_0, debug_commit_cta_x_1, debug_commit_cta_x_2, debug_commit_cta_x_3
    ,output logic [31:0] debug_commit_cta_y_0, debug_commit_cta_y_1, debug_commit_cta_y_2, debug_commit_cta_y_3
    ,output logic [31:0] debug_commit_cta_z_0, debug_commit_cta_z_1, debug_commit_cta_z_2, debug_commit_cta_z_3
    ,output logic [2:0] debug_commit_warp_0, debug_commit_warp_1, debug_commit_warp_2, debug_commit_warp_3
    ,output logic [31:0] debug_commit_pc_0, debug_commit_pc_1, debug_commit_pc_2, debug_commit_pc_3
    ,output logic [127:0] debug_commit_instruction_0, debug_commit_instruction_1, debug_commit_instruction_2, debug_commit_instruction_3
    ,output logic [31:0] debug_commit_execute_mask_0, debug_commit_execute_mask_1, debug_commit_execute_mask_2, debug_commit_execute_mask_3
    ,output logic [7:0] debug_commit_dest_0, debug_commit_dest_1, debug_commit_dest_2, debug_commit_dest_3
    ,output logic [31:0] debug_commit_lane_mask_0, debug_commit_lane_mask_1, debug_commit_lane_mask_2, debug_commit_lane_mask_3
    ,output logic [1023:0] debug_commit_data_0, debug_commit_data_1, debug_commit_data_2, debug_commit_data_3
    ,output logic debug_commit_predicate_valid_0, debug_commit_predicate_valid_1, debug_commit_predicate_valid_2, debug_commit_predicate_valid_3
    ,output logic [2:0] debug_commit_predicate_0, debug_commit_predicate_1, debug_commit_predicate_2, debug_commit_predicate_3
    ,output logic [31:0] debug_commit_predicate_data_0, debug_commit_predicate_data_1, debug_commit_predicate_data_2, debug_commit_predicate_data_3
);
  AecEvalTop u_frontend (
    .clock(clk), .reset(!rst_n),
    .io_load_valid(load_valid), .io_load_ready(load_ready), .io_load_target(load_target), .io_load_addr(load_addr), .io_load_data(load_data), .io_load_strb(load_strb),
    .io_launch_valid(launch_valid), .io_launch_ready(launch_ready), .io_grid_x(grid_x), .io_grid_y(grid_y), .io_grid_z(grid_z), .io_block_x(block_x), .io_block_y(block_y), .io_block_z(block_z), .io_program_instructions(program_instructions),
    .io_result_valid(result_valid), .io_result_ready(result_ready), .io_result_status(result_status), .io_result_cycles(result_cycles),
    .io_read_valid(read_valid), .io_read_ready(read_ready), .io_read_addr(read_addr), .io_read_data_valid(read_data_valid), .io_read_data(read_data),
    .io_mem_req_valid(mem_req_valid), .io_mem_req_ready(mem_req_ready), .io_mem_req_write(mem_req_write), .io_mem_req_addr(mem_req_addr), .io_mem_req_wdata(mem_req_wdata), .io_mem_req_wstrb(mem_req_wstrb), .io_mem_req_tag(mem_req_tag),
    .io_mem_rsp_valid(mem_rsp_valid), .io_mem_rsp_ready(mem_rsp_ready), .io_mem_rsp_rdata(mem_rsp_rdata), .io_mem_rsp_tag(mem_rsp_tag), .io_mem_rsp_error(mem_rsp_error)
    , .io_debug_commit_valid_0(debug_commit_valid_0), .io_debug_commit_valid_1(debug_commit_valid_1), .io_debug_commit_valid_2(debug_commit_valid_2), .io_debug_commit_valid_3(debug_commit_valid_3)
    , .io_debug_commit_cta_x_0(debug_commit_cta_x_0), .io_debug_commit_cta_x_1(debug_commit_cta_x_1), .io_debug_commit_cta_x_2(debug_commit_cta_x_2), .io_debug_commit_cta_x_3(debug_commit_cta_x_3)
    , .io_debug_commit_cta_y_0(debug_commit_cta_y_0), .io_debug_commit_cta_y_1(debug_commit_cta_y_1), .io_debug_commit_cta_y_2(debug_commit_cta_y_2), .io_debug_commit_cta_y_3(debug_commit_cta_y_3)
    , .io_debug_commit_cta_z_0(debug_commit_cta_z_0), .io_debug_commit_cta_z_1(debug_commit_cta_z_1), .io_debug_commit_cta_z_2(debug_commit_cta_z_2), .io_debug_commit_cta_z_3(debug_commit_cta_z_3)
    , .io_debug_commit_warp_0(debug_commit_warp_0), .io_debug_commit_warp_1(debug_commit_warp_1), .io_debug_commit_warp_2(debug_commit_warp_2), .io_debug_commit_warp_3(debug_commit_warp_3)
    , .io_debug_commit_pc_0(debug_commit_pc_0), .io_debug_commit_pc_1(debug_commit_pc_1), .io_debug_commit_pc_2(debug_commit_pc_2), .io_debug_commit_pc_3(debug_commit_pc_3)
    , .io_debug_commit_instruction_0(debug_commit_instruction_0), .io_debug_commit_instruction_1(debug_commit_instruction_1), .io_debug_commit_instruction_2(debug_commit_instruction_2), .io_debug_commit_instruction_3(debug_commit_instruction_3)
    , .io_debug_commit_execute_mask_0(debug_commit_execute_mask_0), .io_debug_commit_execute_mask_1(debug_commit_execute_mask_1), .io_debug_commit_execute_mask_2(debug_commit_execute_mask_2), .io_debug_commit_execute_mask_3(debug_commit_execute_mask_3)
    , .io_debug_commit_dest_0(debug_commit_dest_0), .io_debug_commit_dest_1(debug_commit_dest_1), .io_debug_commit_dest_2(debug_commit_dest_2), .io_debug_commit_dest_3(debug_commit_dest_3)
    , .io_debug_commit_lane_mask_0(debug_commit_lane_mask_0), .io_debug_commit_lane_mask_1(debug_commit_lane_mask_1), .io_debug_commit_lane_mask_2(debug_commit_lane_mask_2), .io_debug_commit_lane_mask_3(debug_commit_lane_mask_3)
    , .io_debug_commit_data_0(debug_commit_data_0), .io_debug_commit_data_1(debug_commit_data_1), .io_debug_commit_data_2(debug_commit_data_2), .io_debug_commit_data_3(debug_commit_data_3)
    , .io_debug_commit_predicate_valid_0(debug_commit_predicate_valid_0), .io_debug_commit_predicate_valid_1(debug_commit_predicate_valid_1), .io_debug_commit_predicate_valid_2(debug_commit_predicate_valid_2), .io_debug_commit_predicate_valid_3(debug_commit_predicate_valid_3)
    , .io_debug_commit_predicate_0(debug_commit_predicate_0), .io_debug_commit_predicate_1(debug_commit_predicate_1), .io_debug_commit_predicate_2(debug_commit_predicate_2), .io_debug_commit_predicate_3(debug_commit_predicate_3)
    , .io_debug_commit_predicate_data_0(debug_commit_predicate_data_0), .io_debug_commit_predicate_data_1(debug_commit_predicate_data_1), .io_debug_commit_predicate_data_2(debug_commit_predicate_data_2), .io_debug_commit_predicate_data_3(debug_commit_predicate_data_3)
  );
endmodule

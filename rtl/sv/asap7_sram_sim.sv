// Local functional stand-ins for the locked ASAP7 native SRAM views.
// Judged simulation/PPA uses the official views identified by Track-B's lock.
`define AEC_SIM_SRAM(NAME, AW, DW, DEPTH) \
module NAME ( \
  input clk, input [AW-1:0] ADDRESS, input [DW-1:0] wd, \
  input banksel, input read, input write, output reg [DW-1:0] dataout \
); \
  reg [DW-1:0] mem [0:DEPTH-1]; \
  always @(posedge clk) begin \
    if (banksel && write) mem[ADDRESS] <= wd; \
    else if (banksel && read) dataout <= mem[ADDRESS]; \
  end \
endmodule

`AEC_SIM_SRAM(srambank_64x4x32_6t122, 8, 32, 256)
`AEC_SIM_SRAM(srambank_128x4x32_6t122, 9, 32, 512)
`AEC_SIM_SRAM(srambank_256x4x32_6t122, 10, 32, 1024)
`AEC_SIM_SRAM(srambank_64x4x64_6t122, 8, 64, 256)
`undef AEC_SIM_SRAM

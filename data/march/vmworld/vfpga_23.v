`ifndef __CASCADE_DATA_MARCH_VMWORLD_FPGA_23_V
`define __CASCADE_DATA_MARCH_VMWORLD_FPGA_23_V

`include "data/stdlib/stdlib.v"

Root root();

Clock clock();

(*__target="de10", __loc="192.168.8.2:8800"*)
Pad#(4) pad();

(*__target="de10", __loc="192.168.8.3:8800"*)
Led#(8) led();

`endif
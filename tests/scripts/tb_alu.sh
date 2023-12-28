#!/bin/sh

iverilog -o temp/tb_alu.vvp tests/tb_alu.v && vvp -n temp/tb_alu.vvp | grep -v "VCD info"

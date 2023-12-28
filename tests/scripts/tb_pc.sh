#!/bin/sh

iverilog -o temp/tb_pc.vvp tests/tb_pc.v && vvp -n temp/tb_pc.vvp | grep -v "VCD info"

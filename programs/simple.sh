#!/bin/sh

iverilog -o temp/simple.vvp programs/simple.v && vvp -n temp/simple.vvp | grep -v "VCD info"

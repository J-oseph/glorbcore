#!/bin/sh

iverilog -o temp/$1.vvp programs/$1.v && vvp -n temp/$1.vvp | grep -v "VCD info"

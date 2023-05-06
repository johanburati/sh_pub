#!/bin/bash
# Functions

# colors
black="\e[90m"
red="\e[91m"
green="\e[92m"
yellow="\e[93m"
blue="\e[94m"
purple="\e[95m"
cyan="\e[96m"
white="\e[97m"
bold="\e[1m"
reverse="\e[7m"
reset="\e[0m"

# 256-colors
gray="\x1b[38;5;244m"

export black red green yellow blue purple cyan white bold reverse reset

function color { echo -e "\e[$(shuf -i 31-36 -n 1)m$@\e[0m"; }
export -f color

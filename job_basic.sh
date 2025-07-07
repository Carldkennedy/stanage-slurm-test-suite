#!/bin/bash
#SBATCH --partition=sheffield
#SBATCH --output=basic.out
hostname && module avail > /dev/null && echo OK

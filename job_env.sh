#!/bin/bash
#SBATCH --partition=sheffield
#SBATCH --output=env.out
env | grep SLURM

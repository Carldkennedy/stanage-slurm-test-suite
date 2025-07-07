#!/bin/bash
#SBATCH --partition=sheffield
#SBATCH --array=1-4
#SBATCH --output=array_%A_%a.out
echo "Hello from task $SLURM_ARRAY_TASK_ID"

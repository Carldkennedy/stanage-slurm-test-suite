#!/bin/bash
#SBATCH --partition=sheffield
#SBATCH --cpus-per-task=2
#SBATCH --mem=100M
#SBATCH --output=res.out
echo "CPUs: $SLURM_CPUS_PER_TASK"; free -m | grep Mem:

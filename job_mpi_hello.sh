#!/bin/bash
#SBATCH --partition=sheffield
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --output=mpi_hello.out
#SBATCH --job-name=mpi_hello

module load OpenMPI/4.1.4-GCC-12.2.0

srun --export=ALL ./hello


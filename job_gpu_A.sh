#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gres=gpu:2
#SBATCH --mem=82G
#SBATCH --output=gpu_A.out
module load CUDA
nvidia-smi || echo "GPU not available"

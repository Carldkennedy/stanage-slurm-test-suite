#!/bin/bash
#SBATCH --partition=gpu-h100
#SBATCH --qos=gpu
#SBATCH --gres=gpu:2
#SBATCH --mem=82G
#SBATCH --output=gpu_H.out
module load CUDA
nvidia-smi || echo "GPU not available"

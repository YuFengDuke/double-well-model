#!/bin/bash

#SBATCH --mail-user=yufeng.physics@gmail.com
#SBATCH --mail-type=end
#SBATCH -e slurm.err
#SBATCH -p brunellab-gpu
#SBATCH -c 20
#SBATCH --mem-per-cpu=4G

module load Matlab
matlab -nodisplay -nosplash < experiment_flat_limit.m

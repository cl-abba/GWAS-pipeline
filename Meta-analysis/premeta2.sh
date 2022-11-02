#!/bin/bash
#SBATCH --account=your-account
#SBATCH --time=02:00:00
#SBATCH --array=1-22
#SBATCH --job-name=premeta
#SBATCH --error=premeta.err
#SBATCH --output=premeta.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem-per-cpu=4G
#SBATCH --ntasks=3

module load nixpkgs/16.09 gcc/5.4.0
module load python/3.8.0
module load r/3.3.3

# This script uses the python script that comes along when you download Metasoft. The first line is calling the python script, the second line is the output name,
# Followed by lines with the summary statistics for each study.

python plink2metasoft2.py \
  /path-to-output/chr${SLURM_ARRAY_TASK_ID} \
  /path-to-premeta-files-study1/premeta-study1-chr${SLURM_ARRAY_TASK_ID}.out \
  /path-to-premeta-files-study2/premeta-study2-chr${SLURM_ARRAY_TASK_ID}.out 

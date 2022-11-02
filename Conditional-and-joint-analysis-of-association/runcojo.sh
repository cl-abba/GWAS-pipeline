#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=1:00:00
#SBATCH --array=1-22
#SBATCH --job-name=gcta_cojo
#SBATCH --output=gcta_cojo.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=8G
#SBATCH --cpus-per-task=3

module load nixpkgs/16.09
module load gcc/5.4.0
module load openmpi/2.0.2
module load gcta/1.26.0

# GCTA is also installed in the Calculon server, you may need to modify the loaded modules if you run it there.

gcta64 \
  --bfile chr${SLURM_ARRAY_TASK_ID}_LDref \
  --chr ${SLURM_ARRAY_TASK_ID} \
  --cojo-file cojo.out \
  --cojo-slct \
  --cojo-p 5e-8 \ # This option is only valid in conjunction with --cojo-slct.
  --out chr${SLURM_ARRAY_TASK_ID}-GCTA-COJO

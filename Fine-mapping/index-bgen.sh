#!/bin/bash

#SBATCH --account=your-account
#SBATCH --job-name=index-bgen
#SBATCH --array=1-5
#SBATCH --mail-type=ALL
#SBATCH --mail-user=youremail@address.com
#SBATCH --mem=8G
#SBATCH --time=0:10:0
#SBATCH --output=index-bgen.out
#SBATCH --error=index-bgen.err

# Note: bgenix is installed in calculon and Compute Canada
module load nixpkgs/16.09 gcc/5.4.0 bgen/1.1.4

# This is a very simple and quick script to index the BGEN file using bgenix, which is necessary for LDstore and FINEMAP.
# Note that the sbatch arrays correspond to the number of subsets that will be fine mapped.
bgenix -g finemap-subset${SLURM_ARRAY_TASK_ID}.bgen -index

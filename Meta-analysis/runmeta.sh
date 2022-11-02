#!/bin/bash
#SBATCH --account=your-account
#SBATCH --time=3:00:00
#SBATCH --array=1-22
#SBATCH --job-name=run-meta
#SBATCH --output=run-meta.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=10G

module load nixpkgs/16.09
module load java/13.0.1

java \
  -jar /path-to-Metasoft-download/Metasoft.jar \
  -input /path-to-meta-files/chr${SLURM_ARRAY_TASK_ID}.meta \
  -output chr${SLURM_ARRAY_TASK_ID}-outputprefix.out \
  -log chr${SLURM_ARRAY_TASK_ID}-outputprefix.log \
  -binary_effects \
  -mvalue \
  -mvalue_p_thres 5E-8

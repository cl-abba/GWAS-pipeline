#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=3:00:00
#SBATCH --job-name=pruning2
#SBATCH --output=pruning2.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load StdEnv/2020
module load plink/1.9b_6.21-x86_64

plink --bfile /path-to-notimputed-file/filename  --extract /path-to-prunein-file/filename.prune.in --make-bed --out outputprefix

#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=15:00:00
#SBATCH --job-name=samples2keep-notimputed
#SBATCH --output=samples2keep-notimputed.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load StdEnv/2020 gcc/9.3.0 bcftools/1.13

bcftools view -S /path-to-sampleslist/sampleslist-filename.txt /path-to-vcf-file/filename.vcf.gz -Oz > outputprefix.vcf.gz

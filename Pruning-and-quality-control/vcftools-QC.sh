#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=24:00:00
#SBATCH --job-name=vcftools-QC
#SBATCH --output=vcftools-QC.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load nixpkgs/16.09  intel/2018.3 vcftools/0.1.16

for i in {1..22}
do
vcftools --gzvcf /path-to-filtered-files/chr${i}filename.vcf.gz  --maf 0.01 --hwe 1e-6 --max-missing 0.02 --recode --recode-INFO-all --out chr${i}outputprefix

# Note: --recode indicates to generate a new vcf output with the applied filters and --recode-INFO-all indicates to keep all INFO flags from the old vcf in the new one.

done 

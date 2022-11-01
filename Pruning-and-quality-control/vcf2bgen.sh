#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=24:00:00
#SBATCH --job-name=vcf2bgen
#SBATCH --output=vcf2bgen.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load StdEnv/2020 nixpkgs/16.09 plink/2.00-10252019-avx2

for i in {1..22}
do
plink2 --vcf /path-to-vcf-files/chr${i}filename.recode.vcf 'dosage=DS' --make-pgen erase-phase --out chr${i}tmp-rmPhase;
plink2 --pfile /path-to-tmp-file/chr${i}tmp-rmPhase --export bgen-1.2 ref-first bits=8 --out chr${i}outputprefix
done

#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=2:00:00
#SBATCH --array=1-22
#SBATCH --job-name=make-bfile-cojo
#SBATCH --output=make-bfile-cojo.out
#SBATCH --error=make-bfile-cojo.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=15G
#SBATCH --cpus-per-task=3

module load nixpkgs/16.09
module load plink/2.00-10252019-avx2

plink2 \
        --vcf /path-to-imputed-vcf-files/chr${SLURM_ARRAY_TASK_ID}.vcf.gz 'dosage=DS' \ 
        --exclude-if-info "INFO < 0.8" \
        --make-bed \
        --out chr${SLURM_ARRAY_TASK_ID}_LDref

# Genotype file is serving as a reference, so it is not required to be limited to a particular subset of individuals

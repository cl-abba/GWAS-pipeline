#This script can be used to extract desired snp

#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=3:00:00
#SBATCH --job-name=extract-snp 
#SBATCH --output=extract-snp.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load nixpkgs/16.09
module load plink/2.00-10252019-avx2

plink2 \
    --vcf /path-to-vcf-file/filename.vcf.gz \
    --snp rs12345678 \
    --make-bed \
    --out outputprefix 

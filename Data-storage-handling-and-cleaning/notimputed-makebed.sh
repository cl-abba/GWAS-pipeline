#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=3:00:00
#SBATCH --job-name=notimputed-makebed
#SBATCH --output=notimputed-makebed
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=15G

module load StdEnv/2020 plink/1.9b_6.21-x86_64

plink \
        --vcf  /path-to-vcf-file/filename.vcf.gz --make-bed --out outputprefix

#Note: PLINK2 utilizes slightly different binary files termed pgen/pvar/psam; if bed/bim/fam files are preferred, using PLINK1.9 will do the trick

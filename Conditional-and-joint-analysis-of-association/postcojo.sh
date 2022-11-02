#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=1:00:00
#SBATCH --array=1-22
#SBATCH --job-name=gcta_cojo
#SBATCH --output=gcta_cojo_GG.out
#SBATCH --error=gcta_cojo_GG.err
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=8G
#SBATCH --cpus-per-task=3

# Get a list of the chromosomes for which there is an output:
ls /your-path-to-COJO-output/chr*-GCTA-COJO.jma.cojo > list-COJO-chrs.txt

# Extract the header:
file1=$(sed -n 1p list-COJO-chrs.txt)
awk 'NR==1' ${file1} > /your-path-to-COJO-output/pheno-all-chrs.jma.cojo
rows=$(wc -l list-COJO-chrs.txt | awk '{print $1}')
for ((i=1;i<=$rows;i++))
do
  file=$(sed -n ${i}p list-COJO-chrs.txt)
  awk 'NR>1' ${file} >> /your-path-to-COJO-output/pheno-all-chrs.jma.cojo
done

# This script is small and quick, does not necessarily require a job.

#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=20:00:00
#SBATCH --job-name=index-bgen
#SBATCH --output=index-bgen.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=20G

module load nixpkgs/16.09 gcc/5.4.0 bgen/1.1.4

for i in {1..22};
do 
    bgenix -g /path-to-bgen-files/chr${i}filename.bgen -index;     
done

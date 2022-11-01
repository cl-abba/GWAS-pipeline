#!/bin/bash

#SBATCH --account=your-account
#SBATCH --time=5:00:00
#SBATCH --job-name=saige-install
#SBATCH --output=docker.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --mem=5G

module load singularity/3.8

singularity build /path-to-project-directory/saige_v1.0.5.sif docker://wzhou88/saige:1.0.5 
        
#Note: This may have changed since the time of publication, be sure to check the SAIGE GitHub for the most up-to-date version.

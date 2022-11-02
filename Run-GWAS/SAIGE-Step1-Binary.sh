#!/bin/bash 

#SBATCH --account=your-account
#SBATCH --time=5:00:00
#SBATCH --job-name=SAIGE-Step1-binary
#SBATCH --output=SAIGE-Step1-binary.out
#SBATCH --mail-user=youremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G

module load singularity/3.8

singularity exec -B /project -B /scratch -B /localscratch /path-to-SAIGE-docker/saige_v1.0.5.sif step1_fitNULLGLMM.R \
        --plinkFile=genotype-filename \
        --phenoFile=phenotype-filename.txt \
        --phenoCol=column-name \
        --covarColList=Sex,Age,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 \
        --sampleIDColinphenoFile=ID \
        --traitType=binary \
        --outputPrefix=/path-to-output/outputprefix \
        --nThreads=8 \
        --LOCO=FALSE

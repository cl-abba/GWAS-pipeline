#!/bin/bash 

#SBATCH --account=your-account
#SBATCH --time=5:00:00
#SBATCH --job-name=SAIGE-Step2-Linear
#SBATCH --output=SAIGE-Step2-Linear.out
#SBATCH --error=SAIGE-Step2-Linear.err
#SBATCH --mail-user=c.abbatangelo@mail.utoronto.ca
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=1G

module load singularity/3.8

for i in {1..22}
do
singularity exec -B /project -B /scratch -B /localscratch /path-to-SAIGE-docker/saige_v1.0.5.sif step2_SPAtests.R \
--bgenFile=chr${i}filename.bgen \
--bgenFileIndex=chr${i}filename.bgen.bgi \
--sampleFile=chr${i}filename.sample \
--AlleleOrder=ref-first \
--minMAF=0.01 \
--chrom=${i} \
--minMAC=10 \
--GMMATmodelFile=filename.rda \
--varianceRatioFile=filename.varianceRatio.txt \
--SAIGEOutputFile=chr${i}filename.out \
--is_imputed_data=TRUE \
--is_Firth_beta=TRUE \
--pCutoffforFirth=0.01 \
--LOCO=FALSE;
done

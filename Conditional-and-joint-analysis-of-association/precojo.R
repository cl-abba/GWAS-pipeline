# Format for COJO analysis file: SNP A1 A2 freq b se p N
# In SAIGE the effect allele is Allele2, while in GCTA it is A1, so be careful with naming the columns

library(dplyr)

# Read in data for GWAS summary statistics:
df_study1 <- read.delim("gwas-output-study1-clean-file.out", sep=" ", header=TRUE)
df_study1 <- data.frame(df_study1)
head(df_study1)

df_study2 <- read.delim("gwas-output-study2-clean-file.out", sep=" ", header=TRUE)
df_study2 <- data.frame(df_study2)
head(df_study2)

# Only keep relevant columns (MarkerID and AF_Allele2 from both, but CHR, POS, Allele1, Allele2 only from one of data frames):
df_study1b <- df_study1[,c(1,2,3,4,5,6)] 
head(df_study1b)
df_study2b <- df_study2[,c(1,6)] 
head(df_study2b)

# Change names of columns:
names(df_study1b)[names(df_study1b) == "AF_Allele2"] <- "freq1"
head(df_study1b)
names(df_study2b)[names(df_study2b) == "AF_Allele2"] <- "freq2"
head(df_study2b)

# Join gsa and cptp data frames using "MarkerID" as the key:
df_gwas = inner_join(df_study1b, df_study2b, by = 'MarkerID')
df_head(df_gwas)
nrow(df_gwas) ##6649898

# Change order (optional):
df_gwas <- df_gwas[,c(1,3,4,5,6,2,7)] 
head(df_gwas)

# Calculate weighted frequency (to do this multiple the freq1 column by Nstudy1/Ntotal and repeat for freq2 with study2, finally sum the two frequencies):
    ## Nstudy1=
    ## Nstudy2=
    ## Ntotal=
    ## weight_study1=Nstudy1/Ntotal
    ## weight_study2=Nstudy2/Ntotal
    df_gwas$freq1 <- df_gwas$freq1* #Insert weight_study1
    df_gwas$freq2 <- df_gwas$freq2* #Insert weight_study2
    df_gwas$freq <- rowSums(cbind(df_gwas$freq1, df_gwas$freq2), na.rm = T )
    head(df_gwas)

# Create SNP column to be able to join with meta statistics:
df_gwas$SNP <- paste(df_gwas$CHR, df_gwas$POS, df_gwas$Allele1, df_gwas$Allele2, sep=":")
head(df_gwas)

# Remove other columns now, keeping only the Marker ID, SNP, Allele1, Allele2 and new weighted frequency column:
df_gwas2 <- df_gwas[,c(9,1,4,5,8)] 
head(df_gwas2)

# Read in meta data:
df_meta <- read.delim("meta-pheno-clean-file.txt", sep=" ", header=TRUE) # Cleaned meta file containing the studies being investigated
df_meta <- data.frame(df_meta)
head(df_meta)
nrow(df_meta) # Some researchers may choose to only include markers that are present in both data sets, this can be a good way to check if any are lost during the script

# Create matching identifier for SNP:
df_meta$SNP <- paste(df_meta$CHR, df_meta$POS, df_meta$A1, df_meta$A2, sep=":")
head(df_meta)

# Join gwas and meta data frames using "SNP" as the key:
df_cojo = inner_join(df_gwas2, df_meta, by = 'SNP')
head(df_cojo)
nrow(df_cojo) 

# Create column for N:
df_cojo$N <- cojo$STUDy
df_cojo$N[df_cojo$STUDY==1] <- # Insert sample size of study 1
df_cojo$N[df_cojo$STUDY==2] <- # Insert sample size of study 2
head(_dfcojo)

# Keep columns required for the cojo (SNP A1 A2 freq b se p N):
df_cojo2 <- df_cojo[,c(2,4,3,5,12,13,11,20)] 
head(df_cojo2)

# Rename columns (Important! A1 should be the effect allele, and freq should be the freq of that allele):
names(df_cojo2)[names(df_cojo2) == "PVALUE_FE"] <- "p"
names(df_cojo2)[names(df_cojo2) == "BETA_FE"] <- "b"
names(df_cojo2)[names(df_cojo2) == "STD_FE"] <- "se"
names(df_cojo2)[names(df_cojo2) == "Allele2"] <- "A1"
names(df_cojo2)[names(df_cojo2) == "Allele1"] <- "A2"
names(df_cojo2)[names(df_cojo2) == "MarkerID"] <- "SNP"
head(df_cojo2)

write.table(df_cojo2, file = "cojo-file.out", sep =" ", col.names = TRUE, row.names = FALSE, quote = FALSE)


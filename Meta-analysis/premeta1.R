# Read in data:

df1 <- read.delim("output-clean.out", sep=" ", header=TRUE) ## Note - this is the cleaned output from SAIGE
df2 <- data.frame(df1)
head(df2)

df2$SNP <- paste(df2$CHR, df2$POS, df2$Allele1, df$Allele2sep=":")
head(df2)

df3 <- within(df2, rm(MarkerID))
df4 <- within(df3, rm(Tstat))
head(df4)

colnames(df4)

# Rename columns where names are "Allele1", "Allele2", "AF_Allele2", "imputationInfo", "p.value":
names(df4)[names(df4) == "Allele1"] <- "A1"
names(df4)[names(df4) == "Allele2"] <- "A2"
names(df4)[names(df4) == "AF_Allele2"] <- "FRQ"
names(df4)[names(df4) == "imputationInfo"] <- "INFO"
names(df4)[names(df4) == "POS"] <- "BP"
names(df4)[names(df4) == "p.value"] <- "P"

head(df4)

df5 <- df4[, c(1, 10, 2, 3, 4, 5, 6, 7, 8, 9)]
head(df5)

# Last apply a correction to the SE column but multiplying it by the squared root of the lambda value for the specific GWAS we are working with 

# Square root of the lambda values for linear models:

sqrt_l= sqrt() ## Insert the lambda value you would like to square root in the brackets
df5$SE <- df5$SE*sqrt_l
head(df5)

# Write the new files into csv files (separate by chromosome with dplyr):
write.table(df5, file = "outputprefix.csv", sep =",", col.names = TRUE, row.names = FALSE, quote = FALSE)

# Last, separate by chromosome:
pre_meta <- read.delim("outputprefix.csv", sep = ",", header = TRUE)
head(pre_meta)
chr1_sub <- pre_meta %>% filter(CHR == "1")

# Check to see what it looks like:
tail(chr1_sub)

chr2_sub <- pre_meta %>% filter(CHR == "2")

# Can complete individually for each chromosome, or set up a for loop if all chromosomes are desired.
write.table(chr1_sub, file = "premeta-chr1.out", sep =" ", col.names = TRUE, row.names = FALSE, quote = FALSE)
write.table(chr2_sub, file = "premeta-chr2.out", sep =" ", col.names = TRUE, row.names = FALSE, quote = FALSE)

# Once again, can complete individually for each chromosome, or set up a for loop if all chromosomes are desired

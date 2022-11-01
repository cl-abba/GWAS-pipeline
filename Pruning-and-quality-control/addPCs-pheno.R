library(dplyr)
library(readr) 
library(plyr)

# Load in pheno data files
# Using read_csv from the readr package here
pheno = read_csv('phenotype-filename.csv')

# Load in PCs - it's important these retain the column names
# Header = TRUE by default in read_csv
PC_list = read_csv('PClist-filename.csv')

# Create files with only CPTP PCs:
pheno_PC = inner_join(pheno, PC_list, by = 'ID')

# Check if this removed any rows:
nrow(pheno)
nrow(PC_list) ## Ideally, no rows will be removed

# Can check out what the data look like if you want:
head(pheno_PC)

# Writing these to file using write_csv from readr
write_csv(pheno_PC, file = 'outputprefix.csv')

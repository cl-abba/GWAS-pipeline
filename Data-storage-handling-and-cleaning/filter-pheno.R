# Package imports -

# dplyr is an all-in-one toolkit for data frame operations - use it for inner_join.
# readr offers functions to read files into R but is a bit 'smarter' with defaults.
library(dplyr)
library(readr) 

# Load in pheno data file using read_csv from the readr package here:
pheno = read_csv('phenotype-filename.csv')

# Load in ID files - it's important these retain the column names (Header = TRUE by default in read_csv):
ID_list = read_csv('IDlist-filename.csv')

# Create files with only desired IDs:
    ## inner_join takes in two data frames and then one or more 'keys'
    ## Set the key to the ID column
    ## Since ID is present in both the phenotype file and the ID file - 
    ## inner_join only keeps rows when their ID values are in *both* datasets
pheno_filtered = inner_join(pheno, ID_list, by = 'ID')

# How many rows did this remove?
nrow(pheno) 
nrow(pheno_filtered)

# Writing these to file using write_csv from readr:
write_csv(pheno_filtered, file = 'output.csv')

# Or to .txt for easy use with PLINK and other command line tools:
    ##write.table(pheno_filtered, file = "output.txt", sep =" ", col.names = TRUE, row.names = FALSE, quote = FALSE)

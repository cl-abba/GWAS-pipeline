# Lots of colour options here: http://sape.inf.usi.ch/quick-reference/ggplot2/colour 
# Default will be blue and yellow if you do not indicate differently (many options including colour blind friendly ones)

# Give the SNPs unique names:
df1 <- read.delim("output-pvalManhattan.out", sep=" ", header=TRUE)
df2 <- data.frame(df1)
head(df2)
df2$SNPID <- paste (df2$CHR, df2$POS, sep="-")
head(df2)

# Write.table(df2, file = "SAIGE_CPTPM2_pvalManhattan_snpid.txt", sep = " ", col.names = TRUE):

df3 <- within(df2, rm(MarkerID))
head(df3)
write.table(df3, file = "output-snpid.txt", sep =" ", col.names = TRUE, row.names = FALSE, quote = FALSE)

# Now compute plot:
home_dir="/path-to-output-file"
my_colours <- c('deepskyblue2', 'seagreen3')

                 # Suffix name for the output manhattan plot:
                 plot_name = "outputsuffix"
                 manhattan_filename <- paste("manhattan-", plot_name, sep=" ") ## Do not need to change this line either
                 
                 # Run the function:
                 gg.manhattan(path = paste(home_dir, sep=" "), ## Can modify if need to change the path for where the data is
                              df = "output-snpid.txt", ## Text file, separated by white space (sep= " "), with 4 columns: SNP, CHR, POS, PVALUE, in that order with header, but does not need to have a specific header (e.g., SAIGE-output-CPTP-M1-pvalManhattan.out)
                              threshold = 1e-6, ## Y-axis level to plot a horizontal line to delimit threshold (default = 5e-8)
                              colours = my_colours, ## Default = blue and yellow
                              ylims = c(0,20), ## Default = c(0,100)
                              title = "Title") ## Default no title
                 ggsave(file=paste(manhattan_filename, ".png")) ## Or can choose PDF etc.

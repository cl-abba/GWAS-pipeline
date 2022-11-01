df <- read.delim("filename.txt", sep = " ", header = TRUE)
head(df)

df_filter <- df %>% filter(A1 == "2", A2 == "2") # This line is if specific genotypes are required, can remove lines pertaining to filtering if not required
head(df_filter)

df_filter_sub <- df_filter[,-c(3:8)]
head(df_filter_sub)

write.table(df_filter_sub, file = "outputprefix.txt", sep = " ", row.names = FALSE, col.names = TRUE)

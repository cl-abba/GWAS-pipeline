# The following script has been adapted from Dr. Frida Lona Durazo: https://github.com/ape4fld/parra-lab/blob/main/FINEMAP/FINEMAP-regional-plots.R

library(tidyverse)
library(ggplot2)

# Plot the log10(Bayes Factor) results for each region (Y axis; colored by LD).
# Also works to plot the PIP instead, check out the comments on the script below to modify.

for (subset in 1:5) {   # change according to the number of susbsets you are plotting
  
  # Read SNP file from FINEMAP results for each subset:
  snpfile <- read.csv(paste("subset",subset,".snp",sep=""), sep = " ", header = TRUE)
  
  snpfile <- filter(snpfile, prob >= 0)
    
  # Extract the chromosome number:
  chr <- snpfile[1,3]  
  
  # Read the local LD results computed on LDstore:
  ld <- read.csv(paste("subset",subset,".ld",sep=""), sep = " ", header = TRUE)
  
  # Separate rsids and other columns to compute R-squared:
  snps <- colnames(ld[2:ncol(ld)])
  head(ld,n=2)
  name_tmp <- data.frame(ld[,1])
  ld_tmp <- data.frame(ld[,2:ncol(ld)]) 
  ld_tmp <- data.frame(lapply(ld_tmp,"^",2))
  
  # Bind the tables back again:
  ld <- bind_cols(name_tmp, ld_tmp)
  
  # Rename columns:
  colnames(ld) <- c("rsid", snps)
  
  # Join snp table and LD table:
  snp_plot <- left_join(snpfile, ld, by = "rsid")
  
  # Get the label for the legend:
  rsq=expression(paste(r^2))
  
  # Plot and save png:
  for (x in 1:length(snps)) {
    index <- snps[x]
    
    top <- filter(snp_plot, rsid == !!index)   # Filter to retain only index SNP
    
    ### CHANGE THE FOLLOWING LINE FOR THE Y-AXIS TO: < y = "PIP" > to plot PIP instead.
    ggplot(snp_plot, aes_string(x = "position", colour = index, y = "prob")) + 
      scale_y_continuous() +  
      geom_point(colour = "black", size = 4, alpha = 7/10) +
      geom_point(aes_string(colour = index), size = 3.5, shape = 19, alpha = 7/10) + 
      scale_colour_stepsn(colours=c("midnightblue","steelblue1","limegreen","sienna2","mediumvioletred"), name=rsq, breaks=c(0.2, 0.4, 0.6, 0.8), labels=c("0.2","0.4","0.6","0.8")) + # Change colours as desired
      
      ### CHANGE THE FOLLOWING LINE FOR THE Y-AXIS TITLE TO < y = "PIP" > to plot the PIP instead:
      guides(fill=none) + labs( x = paste("Chromosome",chr,sep=" "), y = "prob") +
      
      theme(axis.text.x = element_text(face="bold", size=12), axis.text.y = element_text(face="bold", size=14),
            axis.title.x = element_text(face="bold", size=15), axis.title.y = element_text(face="bold", size=15),
            legend.title = element_text(size=16, face="bold"), legend.text = element_text(size=12),
            panel.background = element_blank(), axis.line = element_line(color = "black"), legend.key=element_blank()) +
      
      geom_point(data = top, colour = "black", size = 7.4, shape = 18) + 
      geom_point(data=top, colour="#FFFF00", shape = 18, size = 6.5) +
     
    ### COMMENT THE FOLLOWING LINE IF PLOTTING THE PIP:
      geom_hline(yintercept=2, colour = "black", linetype="dashed")
    
    ### COMMENT THE FOLLOWING LINE IF PLOTTING THE PIP:
    ggsave(file=paste("subset",subset,"-",snps[x],"-log10BF.png", sep=""))
    
    ### COMMENT THE FOLLOWING LINE IF PLOTTING THE log10BF:
    #ggsave(file=paste("GGsubset",subset,"-",snps[x],"-PIP.png", sep=""))
  }
}

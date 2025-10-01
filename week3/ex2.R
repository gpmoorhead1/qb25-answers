library(tidyverse)

df = read_tsv('/Users/cmdb/git/qb25-answers/week3/AF.txt')

ggplot(df, aes(x=INFO)) + 
  geom_histogram(bins=11) +
  theme_classic() + 
  labs(x='Allele Fraction')

ggsave("/Users/cmdb/git/qb25-answers/week3/AF.png")

# this distribution has SNPS mostly around 50% AF, meaning that there are a lot of heterozygous sites
# there are also some SNPs at 100%, meaning these are homozygous.
# this follows the beta distribution

DP = read_tsv('/Users/cmdb/git/qb25-answers/week3/DP.txt')

ggplot(DP, aes(x=`0`)) + 
  geom_histogram(bins=21) +
  theme_classic() + 
  xlim(0, 20) +
  labs(x='Read Depth')

ggsave("/Users/cmdb/git/qb25-answers/week3/DP.png")

# This distribution represents the amount of times a particular base in the genome is covered by a read. It looks like they got a mean
# depth of around 7x and looks like expected because you would expect variability but not less than 0. 
# This looks like the log-normal distribution.
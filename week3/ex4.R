library(tidyverse)

C = read_tsv('/Users/cmdb/git/qb25-answers/week3/crossovers.txt')

ggplot(C, aes(x=Number_Crossovers)) + 
  geom_histogram(bins=5) +
  theme_classic()

ggsave("/Users/cmdb/git/qb25-answers/week3/crossovers.png")
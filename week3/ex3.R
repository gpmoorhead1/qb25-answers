library(tidyverse)

G = read_tsv('/Users/cmdb/git/qb25-answers/week3/gt_long.txt')

G$genotype <- as.factor(G$genotype)

filter(G, sample=='A01_62', CHROM=='chrII') %>%
  ggplot(aes(x=POS, color=genotype, y=sample)) + 
    geom_point() +
    theme_classic() +
    labs(x='Position', y='')
ggsave("/Users/cmdb/git/qb25-answers/week3/3_3-A01_62-genotype.png")

# There are separate, extended sections that are of a single genotype. These transitions indicate where crossover happened during sporulation.


ggplot(G, aes(x=POS, color=genotype, y=sample)) + 
  geom_point() +
  theme_classic() +
  labs(x='Position', y='') +
  facet_wrap(~ CHROM, scales='free_x') 

ggsave("/Users/cmdb/git/qb25-answers/week3/3_4-all_samples-genotype.png")

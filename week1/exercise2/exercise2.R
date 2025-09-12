library(tidyverse)

header <- c( "chr", "start", "end", "count" )
df_kc <- read_tsv('git/qb25-answers/week1/hg19-kc-count.bed', col_names=header )

ggplot(df_kc, aes(x=start, y=count, color=chr)) + 
  geom_line() +
  facet_wrap(~ chr, scales = 'free') +
  theme_classic()

ggsave("~/git/qb25-answers/week1/exercise1.png")

library(tidyverse)

header <- c( "chr", "start", "end", "count" )
dfA <- read_tsv('git/qb25-answers/week1/exercise1/hg19-kc-count.bed', col_names=header )
dfB <- read_tsv('git/qb25-answers/week1/exercise2/hg16-kc-count.bed', col_names=header )

df <- bind_rows( hg19=dfA, hg16=dfB, .id="assembly" )

ggplot(df, aes(x=start, y=count, color=assembly)) + 
  geom_line() +
  facet_wrap(~ chr, scales = 'free') +
  theme_classic()

ggsave("~/git/qb25-answers/week1/exercise2/exercise2.png")

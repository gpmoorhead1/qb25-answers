library(tidyverse)
library(broom)


# Exercise 1

D <- read.csv('/Users/cmdb/git/qb25-answers/week5/aau1043_dnm.csv')
D_filt <- filter(D, Phase_combined %in% c("father", "mother")) %>%
  count(Proband_id, Phase_combined)

A <- read.csv('/Users/cmdb/git/qb25-answers/week5/aau1043_parental_age.csv')

M <- merge(D_filt, A)



# Exercise 2
ggplot(filter(M, Phase_combined=='mother'), aes(x=Mother_age, y=n)) +
  geom_point() +
  theme_classic() +
  labs(
    x = "Mother Age",
    y = "Counts",
  )
ggsave('/Users/cmdb/git/qb25-answers/week5/ex2_a.png')

ggplot(filter(M, Phase_combined=='father'), aes(x=Father_age, y=n)) +
  geom_point() +
  theme_classic() +
  labs(
    x = "Father Age",
    y = "Counts",
  )
ggsave('/Users/cmdb/git/qb25-answers/week5/ex2_b.png')


lm(data=filter(M, Phase_combined=='mother'), formula=n ~ 1 + Mother_age) %>%
  summary()

lm(data=filter(M, Phase_combined=='father'), formula=n ~ 1 + Father_age) %>%
  summary()

# prediction
model_F <- lm(data=filter(M, Phase_combined=='father'), formula=n ~ 1 + Father_age)
newd <- data.frame(Father_age=50.5)
predict(model_F, newd)


# overlapping histogram
ggplot(M, aes(x=n, fill=Phase_combined)) +
  geom_histogram(alpha=0.5, position = "identity") +
  theme_classic() +
  labs(
    x = "Number of DNMs",
    y = "Counts",
    fill='Sex'
  )
ggsave('/Users/cmdb/git/qb25-answers/week5/ex2_c.png')


#  performing t test
t.test(filter(M, Phase_combined=='mother')$n, filter(M, Phase_combined=='father')$n, paired = TRUE)


test_data <- tibble(father_dnms=filter(M, Phase_combined=='father')$n, 
                    mother_dnms=filter(M, Phase_combined=='mother')$n)

lm(data=test_data, formula=father_dnms - mother_dnms ~ 1) %>% summary()


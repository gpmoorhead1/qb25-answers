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


## Problem 3

billboard <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-08-26/billboard.csv')

billboard$time <- as.numeric(billboard$date)

ggplot(billboard, aes(x=time, y=bpm)) +
  geom_point() +
  labs(title='BPM of Top Song Over Time',
       y='BPM of Top Song',
       x='Time (Seconds since 1970)') +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week5/ex4_top-song-bpm_vs_time.png')


ggplot(billboard, aes(x=time, y=acousticness)) +
  geom_point() +
  labs(title='Acousticness of Top Song Over Time',
       y='Acousticness of Top Song',
       x='Time (Seconds since 1970)') +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week5/ex4_top-song-acousticness_vs_time.png')


ggplot(billboard, aes(x=time, y=divisiveness)) +
  geom_point() +
  labs(title='Divisiveness of Top Song Over Time',
       y='Divisiveness of Top Song',
       x='Time (Seconds since 1970)') +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week5/ex4_top-song-divisiveness_vs_time.png')

ggplot(billboard, aes(x=weeks_at_number_one, y=overall_rating)) +
  geom_point() +
  labs(title='Weeks at Number One vs Song Rating',
       y='Rating of Top Song',
       x='Weeks at Number One') +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week5/ex4_top-song-rating_vs_weeks-at-num-one.png')


ggplot(billboard, aes(x=energy, y=happiness)) +
  geom_point() +
  labs(title='Song Energy vs Song Happiness',
       y='Song Happiness',
       x='Song Energy') +
  theme_classic()
ggsave('/Users/cmdb/git/qb25-answers/week5/ex4_top-song-rating_vs_weeks-at-num-one.png')

lm(billboard, formula = happiness ~ 1 + energy + danceability + bpm) %>% summary()




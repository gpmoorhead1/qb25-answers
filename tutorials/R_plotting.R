library(tidyverse)

penguins <- read_delim(
  "https://gist.githubusercontent.com/slopp/ce3b90b9168f2f921784de84fa445651/raw/4ecf3041f0ed4913e7c230758733948bc561f434/penguins.csv",
  delim = ","
)


## histograms

ggplot(data = penguins, mapping = aes(x = bill_length_mm, fill = species)) +
  geom_histogram(bins=40, position = "stack") +
  labs(
    x = "Bill Length (mm)",
    y = "Number of Penguins",
  )

# density

ggplot(data = penguins, mapping = aes(x = bill_length_mm, color = species)) +
  geom_density() +
  labs(
    x = "Bill Length (mm)",
    y = "Number of Penguins",
  ) +
  scale_color_brewer(palette = "Dark2") +
  theme_bw()

# scatter
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point() + 
  scale_color_brewer(palette = "Dark2") +
  theme_classic() +
  xlim(20, 60) +
  ylim(10, 30) +
  geom_abline(slope=.4)


# boxplot
ggplot(penguins, aes(x= species, y = body_mass_g, fill = species)) + 
  geom_boxplot() + 
  theme(legend.position = "none") +
  theme_classic()

ggplot(penguins, aes(x= species, y = body_mass_g, fill = species)) + 
  geom_violin() + geom_point() +
  theme(legend.position = "none") +
  theme_classic()


library(ggbeeswarm)

ggplot(penguins, aes(x=species, y=body_mass_g, color=species)) + 
  geom_beeswarm() + 
  theme(legend.position = "none") +
  theme_classic()


## facets

ggplot(data = penguins %>% filter(!is.na(species)), mapping = aes(x = bill_length_mm, fill = sex)) +
  geom_histogram(bins=40, position = "stack") +
  labs(
    x = "Bill Length (mm)",
    y = "Number of Penguins",
  ) +
  theme_classic() +
  facet_grid(species ~ island)


# barplot

penguins %>%
  group_by(species) %>%
  summarise(n = n()) %>%
  ggplot(aes(x=species, y=n, fill=species)) +
    geom_bar(stat = "identity") +
    theme(legend.position = "none") +
    theme_classic()


penguins %>%
  group_by(species) %>%
  summarise(mean_flipper_len = mean(flipper_length_mm, na.rm = TRUE),
            sd_flipper_len = sd(flipper_length_mm, na.rm=TRUE)) %>%
  ggplot(aes(x=species, 
             y=mean_flipper_len, 
             fill=species,
             ymin = mean_flipper_len - sd_flipper_len,
             ymax = mean_flipper_len + sd_flipper_len)) +
  geom_bar(stat = "identity") +
  geom_errorbar(width=0.25) +
  theme(legend.position = "none") +
  theme_classic()

## lineplot

p1 <- penguins %>%
  group_by(island, species, year) %>%
  summarize(mean_body_mass = mean(body_mass_g, na.rm=TRUE)) %>%
  ggplot(aes(x = year, y = mean_body_mass, color=species)) +
    geom_line() +
    facet_grid(. ~ island) +
    theme_classic() +
    theme(axis.text.x = element_text(angle = 60))

ggsave("~/Desktop/p1.pdf", plot=p1, width=4, heigh=4)

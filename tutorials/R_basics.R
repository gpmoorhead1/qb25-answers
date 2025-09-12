typeof(2L)
typeof(2)
typeof(2.1)

x <- c(10, 4, 2, 45)
x > 3
x[x>3]
4:100

as.character(400)
as.integer(10.1)
as.integer(c(10.1, TRUE))

# vector can only hold homogeneous data types, lists can store heterogenous
my_list <- list(10L, 4.1, "mellow_world")
my_list[3]

# data.frames: columns can be different types
fruits_df <- data.frame(
  fruits = c("raspberry", "banana", 'mango'),
  is_berry = c(TRUE, TRUE, FALSE),
  inventory = c(40, 5, 3)
)

fruits_df[1, 3]
fruits_df[1, 1:2]
fruits_df$is_berry

colnames(fruits_df)
rownames(fruits_df)

## load tidyverse
library(tidyverse)

penguins <- read_delim("https://gist.githubusercontent.com/slopp/ce3b90b9168f2f921784de84fa445651/raw/4ecf3041f0ed4913e7c230758733948bc561f434/penguins.csv", 
           delim = ",")

dim(penguins)
head(penguins)
colnames(penguins)

# pipe operator in tidyverse %>%
penguins %>%
  select(species, island, bill_length_mm)

penguins %>%
  filter(species == "Adelie")

penguins %>%
  filter(species %in% c("Adelie", "Gentoo"))

penguins %>%
  filter(species=="Adelie" & island=='Torgersen')

# mutate adds new columns
penguins <- penguins %>%
  mutate(bill_ratio = bill_length_mm / bill_depth_mm)

# arrange sorts by a column
penguins %>%
  arrange(bill_length_mm)

penguins %>%
  arrange(desc(bill_length_mm))

# group_by and summarize
penguins %>%
  group_by(species) %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm=TRUE))

nests <- tibble(
  species = c("Adelie", "Gentoo", 'Chinstrap'),
  nest_type = c('pebbles', 'stones', 'grass')
)

penguins %>%
  left_join(nests, by = 'species') %>%
  select(species, nest_type)

# pivot_longer(), pivot_wider

penguins_long <- penguins %>%
  pivot_longer(
    cols = c(flipper_length_mm, bill_length_mm),
    names_to = "trait",
    values_to = "value",
  ) %>%
  select(species, island, trait, value)

penguins_long %>%
  pivot_wider (
    names_from = trait,
    values_from = value,
  )

penguins_long

library(tidyverse)

# 3X Coverage
cov3 = read_csv('/Users/cmdb/git/qb25-answers/week11/3x_coverage.txt', col_names=c('coverage'))

lambda <- 3
mu <- 3
sigma <- 1.73

x_range <- seq(min(cov3$coverage), max(cov3$coverage))
poisson_df <- data.frame(
  x = x_range,
  y = dpois(x_range, lambda = lambda)
)


ggplot(cov3, aes(x = coverage)) +
  geom_histogram(aes(y = after_stat(density), fill = "3X Coverage"), 
                 binwidth = 1,
                 color = "black",
                 alpha = 0.7) +
  
  # Overlay Poisson distribution
  geom_line(data = poisson_df, 
            aes(x = x, y = y, color = "Poisson (λ=3)"),
            linewidth = 1.2) +
  
  # Overlay Normal distribution
  stat_function(aes(color = "Normal (μ=3, σ=1.73)"),
                fun = dnorm,
                args = list(mean = mu, sd = sigma),
                linewidth = 1.2,
                n = 1000) +
  
  scale_fill_manual(name = "",
                    values = c("3X Coverage" = "lightblue")) +
  scale_color_manual(name = "",
                     values = c("Poisson (λ=3)" = "red", 
                                "Normal (μ=3, σ=1.73)" = "blue")) +
  
  theme_classic() +
  theme(legend.position = "right") +
  
  labs(title = "3X Coverage Histogram with Distribution Overlays",
       x = "Coverage",
       y = "Density")

ggsave('/Users/cmdb/git/qb25-answers/week11/ex1_3x_cov.png')

# calculate how much of the genome hasn't been sequenced
zero_count <- sum(cov3$coverage == 0)
total_count <- nrow(cov3)
zero_fraction <- zero_count / total_count



# 10X Coverage

cov10 = read_csv('/Users/cmdb/git/qb25-answers/week11/10x_coverage.txt', col_names=c('coverage'))

lambda <- 10
mu <- 10
sigma <- 3.16

x_range <- seq(min(cov10$coverage), max(cov10$coverage))
poisson_df <- data.frame(
  x = x_range,
  y = dpois(x_range, lambda = lambda)
)


ggplot(cov10, aes(x = coverage)) +
  geom_histogram(aes(y = after_stat(density), fill = "10X Coverage"), 
                 binwidth = 1,
                 color = "black",
                 alpha = 0.7) +
  
  # Overlay Poisson distribution
  geom_line(data = poisson_df, 
            aes(x = x, y = y, color = "Poisson (λ=10)"),
            linewidth = 1.2) +
  
  # Overlay Normal distribution
  stat_function(aes(color = "Normal (μ=10, σ=3.16)"),
                fun = dnorm,
                args = list(mean = mu, sd = sigma),
                linewidth = 1.2,
                n = 1000) +
  
  scale_fill_manual(name = "",
                    values = c("10X Coverage" = "lightblue")) +
  scale_color_manual(name = "",
                     values = c("Poisson (λ=10)" = "red", 
                                "Normal (μ=10, σ=3.16)" = "blue")) +
  
  theme_classic() +
  theme(legend.position = "right") +
  
  labs(title = "10X Coverage Histogram with Distribution Overlays",
       x = "Coverage",
       y = "Density")

ggsave('/Users/cmdb/git/qb25-answers/week11/ex1_10x_cov.png')

# calculate how much of the genome hasn't been sequenced
zero_count <- sum(cov10$coverage == 0)
total_count <- nrow(cov10)
zero_fraction <- zero_count / total_count


# 30X Coverage

cov30 = read_csv('/Users/cmdb/git/qb25-answers/week11/30x_coverage.txt', col_names=c('coverage'))

lambda <- 30
mu <- 30
sigma <- 5.47

x_range <- seq(min(cov30$coverage), max(cov30$coverage))
poisson_df <- data.frame(
  x = x_range,
  y = dpois(x_range, lambda = lambda)
)


ggplot(cov30, aes(x = coverage)) +
  geom_histogram(aes(y = after_stat(density), fill = "30X Coverage"), 
                 binwidth = 1,
                 color = "black",
                 alpha = 0.7) +
  
  # Overlay Poisson distribution
  geom_line(data = poisson_df, 
            aes(x = x, y = y, color = "Poisson (λ=30)"),
            linewidth = 1.2) +
  
  # Overlay Normal distribution
  stat_function(aes(color = "Normal (μ=30, σ=5.47)"),
                fun = dnorm,
                args = list(mean = mu, sd = sigma),
                linewidth = 1.2,
                n = 1000) +
  
  scale_fill_manual(name = "",
                    values = c("30X Coverage" = "lightblue")) +
  scale_color_manual(name = "",
                     values = c("Poisson (λ=30)" = "red", 
                                "Normal (μ=30, σ=5.47)" = "blue")) +
  
  theme_classic() +
  theme(legend.position = "right") +
  
  labs(title = "30X Coverage Histogram with Distribution Overlays",
       x = "Coverage",
       y = "Density")

ggsave('/Users/cmdb/git/qb25-answers/week11/ex1_30x_cov.png')

# calculate how much of the genome hasn't been sequenced
zero_count <- sum(cov30$coverage == 0)
total_count <- nrow(cov30)
zero_fraction <- zero_count / total_count

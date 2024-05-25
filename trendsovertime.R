library(dplyr)
library(tidyverse)

us_jail_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-jail-pop.csv")

# Trends Over Time
trends_chart <- us_jail_pop %>%
  filter(year >= 2000) %>%
  group_by(year) %>%
  summarise(
    avg_total_jail_pop = mean(total_jail_pop, na.rm = TRUE),
    avg_black_jail_pop = mean(black_jail_pop, na.rm = TRUE),
    avg_white_jail_pop = mean(white_jail_pop, na.rm = TRUE)
  ) %>%
  ggplot() +
  geom_line(aes(x = year, y = avg_total_jail_pop, color = "Total")) +
  geom_line(aes(x = year, y = avg_black_jail_pop, color = "Black")) +
  geom_line(aes(x = year, y = avg_white_jail_pop, color = "White")) +
  labs(
    title = "Average Jail Population Over Time by Race",
    x = "Year",
    y = "Average Jail Population",
    color = "Population Group"
  )

# Display the chart
# print(trends_chart)
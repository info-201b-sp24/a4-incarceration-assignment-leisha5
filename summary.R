library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(maps)

us_jail_pop <- read_csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-jail-pop.csv")

oldest_year <- min(us_jail_pop$year)
latest_year <- max(us_jail_pop$year)
num_observations <- nrow(us_jail_pop)

avg_jail_pop <- us_jail_pop %>%
  filter(year == current_year) %>%
  summarise(avg_jail_pop = mean(total_jail_pop, na.rm = TRUE)) %>%
  pull(avg_jail_pop)

highest_jail_pop <- us_jail_pop %>%
  filter(year == current_year) %>%
  filter(total_jail_pop == max(total_jail_pop, na.rm = TRUE))

highest_jail_pop_county <- highest_jail_pop$county_name
highest_jail_pop_value <- highest_jail_pop$total_jail_pop

lowest_jail_pop <- us_jail_pop %>%
  filter(year == current_year) %>%
  filter(total_jail_pop == min(total_jail_pop, na.rm = TRUE))

lowest_jail_pop_county <- lowest_jail_pop$county_name
lowest_jail_pop_value <- lowest_jail_pop$total_jail_pop

avg_black_jail_pop <- us_jail_pop %>%
  filter(year == current_year) %>%
  summarise(avg_black_jail_pop = mean(black_jail_pop, na.rm = TRUE)) %>%
  pull(avg_black_jail_pop)

avg_white_jail_pop <- us_jail_pop %>%
  filter(year == current_year) %>%
  summarise(avg_white_jail_pop = mean(white_jail_pop, na.rm = TRUE)) %>%
  pull(avg_white_jail_pop)

library(ggplot2)
library(dplyr)
library(tidyverse)

# Assuming 'us_jail_pop' is the dataset containing jail population data
# Assuming the columns for each race are named 'white_jail_pop', 'black_jail_pop', 'other_jail_pop'
# Assuming 'year' is the variable indicating the year

# Filter the dataset for the year 2018
us_jail_pop_2018 <- filter(us_jail_pop, year == 2018)

# Sum the jail population counts across all counties for each race
race_sums <- us_jail_pop_2018 %>%
  summarise(White = sum(white_jail_pop, na.rm = TRUE),
            Black = sum(black_jail_pop, na.rm = TRUE),
            Other = sum(other_race_jail_pop, na.rm = TRUE),
            AAPI = sum(aapi_jail_pop, na.rm = TRUE),
            Latinx = sum(latinx_jail_pop, na.rm = TRUE),
            Native = sum(native_jail_pop, na.rm = TRUE))

# Reshape the data for plotting
race_data <- race_sums %>%
  pivot_longer(cols = everything(), names_to = "Race", values_to = "Population")

# Create histogram
histogram <- ggplot(data = race_data, aes(x = Race, y = Population, fill = Race)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Jail Population Distribution by Race in 2018",
       x = "Race",
       y = "Total Jail Population",
       fill = "Race")

# Display the histogram
# print(histogram)
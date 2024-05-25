library(readr)
library(dplyr)
library(ggplot2)
library(sf)
library(maps)

latest_year <- max(us_jail_pop$year)

# Map of Jail Population by State
us_jail_pop_state <- us_jail_pop %>%
  filter(year == latest_year) %>%
  group_by(state) %>%
  summarise(avg_jail_pop = mean(total_jail_pop, na.rm = TRUE))

state_lookup <- data.frame(
  state_abbr = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", 
                 "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", 
                 "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", 
                 "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", 
                 "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"),
  state_name = c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
                 "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", 
                 "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", 
                 "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", 
                 "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", 
                 "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", 
                 "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
                 "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", 
                 "Washington", "West Virginia", "Wisconsin", "Wyoming")
)

# Merge us_jail_pop_state with the lookup table to get full state names
us_jail_pop_state_full <- us_jail_pop_state %>%
  left_join(state_lookup, by = c("state" = "state_abbr"))
us_jail_pop_state_full <- us_jail_pop_state_full %>%
  mutate(state_name = tolower(state_name))

# Getting geometry data for states
states_map <- map_data("state")

# Merge with the jail population data
state_jail_pop_map <- inner_join(us_jail_pop_state_full, states_map, by = c("state_name" = "region"))

# Plotting the map
jail_pop_map <- ggplot(state_jail_pop_map, aes(long, lat, group = group, fill = avg_jail_pop)) +
  geom_polygon(color = "black") +
  coord_fixed(1.3) +
  labs(
    title = "Average Jail Population by State in the Current Year",
    fill = "Jail Population"
  ) +
  xlab("Longitude") + ylab("Latitude")


library(readr)
library(dplyr)
library(ggplot2)

# Read the CSV file
merged_data <- read_csv("C:/Users/user/Downloads/merged.csv")

# Checking the data
head(merged_data, 10)

# Get column names
colnames(merged_data)

# Calculate average delays grouped by DayOfWeek
avgdelay_weekdays <- merged_data %>%
  group_by(DayOfWeek) %>%
  summarise(AvgArrDelay = mean(ArrDelay), AvgDepDelay = mean(DepDelay))

# Plotting lineplot for DepDelay and ArrDelay
ggplot(avgdelay_weekdays, aes(x = factor(DayOfWeek), y = AvgDepDelay, group = 1)) +
  geom_line(color = 'green') +
  geom_line(aes(y = AvgArrDelay), color = 'red') +
  scale_x_discrete(labels = c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')) +
  labs(y = 'Average Delays/mins', x = 'DayOfWeek', title = 'Line plot showing the Average Delays per Weekday') +
  theme_minimal() +
  theme(legend.title = element_blank())

# Combine both delays as total delays
merged_data$Total_delay <- merged_data$ArrDelay + merged_data$DepDelay

# Define the time intervals
time_intervals <- cut(merged_data$Total_delay, breaks = c(-Inf, 0, 60, 120, 180, 240, Inf),
                      labels = c('00:00-03:59', '04:00-07:59', '08:00-11:59', '12:00-15:59', '16:00-19:59', '20:00-23:59'))

# Plot boxplot for TotalDelay by TimeOfDay
ggplot(merged_data, aes(x = Total_delay, y = factor(time_intervals))) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16) +
  labs(x = "TotalDelay", y = "TimeOfDay", title = "Horizontal Boxplots of TotalDelay by TimeofDay") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12), axis.text.y = element_text(size = 12))

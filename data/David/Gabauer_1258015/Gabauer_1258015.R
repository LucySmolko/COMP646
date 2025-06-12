# 1. Create an R project and name the folder using your surname and student ID
# (e.g., Gabauer_1258015). Save both the datasets and your R code in this folder.
rm(list=ls())
library(tidyverse)

# 2. Load and merge the life-expectancy.csv and youth-mortality-rate.csv
# datasets by Country and Year, and drop all observations from before 1990.
# Ensure that the datasets are correctly loaded and free from incorrect data
# types, typos, or other data quality issues.
life_expectancy = read_csv("data/life expectancy.csv")
youth_mortality = read_csv("data/youth-mortality-rate.csv")

clean_data = life_expectancy %>%
  inner_join(youth_mortality, by = c("Country", "Year")) %>%
  filter(Year>=1990)

# 3. Create two line charts: one showing youth mortality rates and the other showing 
# life expectancy over time for each country. Identify the country with the
# highest youth mortality rate and the one with the lowest life expectancy in
# 2023. Choose appropriate titles and label the axes clearly.
ggplot(clean_data, aes(x = Year, y = MortalityRate, color=Country)) +
  geom_line() +
  labs(title="Youth Mortality Rate Over Time", x="Year", y="Youth Mortality Rate")

ggplot(clean_data, aes(x = Year, y = LifeExpectancy, color = Country)) +
  geom_line() +
  labs(title="Youth Mortality Rate Over Time", x="Year", y="Youth Mortality Rate")

# 4. What does the following function do, and what is its expected output?
average_by_country = function(data, start_year=2000, end_year=2020) {
  data |>
    filter(Year>=start_year & Year<end_year) |>
    group_by(Country) |>
    summarise(
      avgLifeExpectancy=mean(LifeExpectancy, na.rm=TRUE),
      avgMortalityRate=mean(MortalityRate, na.rm=TRUE)
    ) |>
    mutate(Period=paste0(start_year, "-", end_year))
}

# 5. Use the aforementioned function to calculate the average life expectancy and
# youth mortality rate for the periods 2000–2010 and 2010–2020. You need to
# check the function and ensure that it works as intended. If it has any flaws, 
# it is your responsibility to correct them.
avg_2000_2010 = clean_data |>
  average_by_country(2000, 2010)

avg_2010_2020 <- clean_data |>
  average_by_country(2010, 2020)

# 6. Create a scatterplot based on the dataset for 2000–2010. Add a linear regression 
# line and interpret the result. Use the following command to label the data points:
ggplot(avg_2000_2010, aes(x=avgMortalityRate, y=avgLifeExpectancy)) +
  geom_point() +
  labs(
    title="Average Life Expectancy vs Youth Mortality (2000–2010)",
    x="Average Youth Mortality Rate",
    y="Average Life Expectancy"
  ) + geom_text(aes(label=Country), vjust=-0.7, size=3, check_overlap=TRUE) +
  geom_smooth(method="lm", se=FALSE)

# 7. Create another scatterplot between the average life expectancy and average
# youth mortality rate, where the points are colored by the two different periods.
# Interpret the overall trend when visually comparing the two periods.
avg = bind_rows(avg_2000_2010, avg_2010_2020)

ggplot(avg, aes(x=avgMortalityRate, y=avgLifeExpectancy, color=Period)) +
  geom_point(size=3, alpha=0.7) +
  labs(
    title="Average Life Expectancy vs Youth Mortality",
    x="Average Youth Mortality Rate",
    y="Average Life Expectancy"
  ) + geom_text(aes(label=Country), vjust=-0.7, size=3, check_overlap=TRUE)

# 8. Finally, calculate the differences in life expectancy and youth mortality rates
# between the two periods. Identify the country with the greatest increase in
# life expectancy and the largest decrease in youth mortality.
differences = avg_2000_2010 |>
  inner_join(avg_2010_2020, by='Country') |>
  mutate(
    deltaLifeExpectancy=avgLifeExpectancy.y-avgLifeExpectancy.x,
    deltaMortalityRate =avgMortalityRate.y-avgMortalityRate.x,
  ) |>
  select(Country, deltaLifeExpectancy, deltaMortalityRate)

differences |>
  arrange(desc(deltaLifeExpectancy)) |>
  slice(1)

differences |>
  arrange(deltaMortalityRate) |>
  slice(1)

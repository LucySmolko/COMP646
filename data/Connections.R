
rm(list=ls())

library(DBI)
library(dbplyr)
library(duckdb)
library(readxl)
library(writexl)
library(tidyverse)

options(tibble.width=Inf)

# Load the wage_rate.xlsx correctly
file_path = "wage_rate.xlsx"
wage <- read_excel(file_path)
wage

wage <- read_excel(file_path,
                   col_names=c("Gender", "Experience", "WageRate"),
                   skip=1,
                   col_types=c("text", "numeric", "numeric"))
wage
warnings()

wage <- read_excel(file_path,
                   col_names=c("Gender", "Experience", "WageRate"),
                   skip=1,
                   col_types=c("text", "text", "numeric"))
wage

wage = wage |>
  mutate(
    Experience = if_else(Experience == "Four", "4", Experience),
    Experience = parse_number(Experience)
  )

# How do I compute the average wage rate by gender? Correct all necessary data issues.
wage |>
  group_by(Gender) |>
  summarize(AverageWageRate=mean(WageRate))

wage = wage |>
  mutate(
    Gender = if_else(Gender == "Fmale", "Female", Gender),
    Gender = if_else(Gender == "male", "Male", Gender)
  )

wage |>
  group_by(Gender) |>
  summarize(AverageWageRate=mean(WageRate))
wage
# Compute the number of observations, average wage rate and average work experience by gender.
wage |>
  group_by(Gender) |>
  summarize(
    Number=length(WageRate),
    AverageWageRate=mean(WageRate), 
    AverageExperience=mean(Experience))

?length

# Separate the data by gender
Male = wage |>
  filter(Gender=="Male")
Male

Female = wage |>
  filter(Gender=="Female")
Female

# How do I run a regression of wage rate on experience for each gender?
summary(lm(WageRate ~ Experience, data=Male))
summary(lm(WageRate ~ Experience, data=Female))

# Visualize the relation between wage and experience and color the data points by gender
ggplot(wage, aes(x=Experience, y=WageRate, color=Gender)) +
  geom_point() +
  labs(
    title="Wage Rate vs Experience by Gender in 2020",
    x="Experience",
    y="Wage Rate"
  )

# Add a regression line for males and females
ggplot(wage, aes(x=Experience, y=WageRate, color=Gender)) +
  geom_point() +
  geom_smooth(method="lm", se=TRUE) +
  labs(
    title="Wage Rate vs Experience by Gender in 2020",
    x="Experience",
    y="Wage Rate"
  )



# Connect to a DuckDB database and name it 'WageRateDB'?
con <- dbConnect(duckdb(), dbdir="WageRateDB")

# Load the wage rate dataset of 1990, 2000, 2010, and 2020
dbWriteTable(con, "WageRate1990", read_excel("data/wage_rate_1990.xlsx"))
dbWriteTable(con, "WageRate2000", read_excel("data/wage_rate_2000.xlsx"))
dbWriteTable(con, "WageRate2010", read_excel("data/wage_rate_2010.xlsx"))
dbWriteTable(con, "WageRate2020", read_excel("data/wage_rate_2020.xlsx"))

dbWriteTable(con, "WageRate1990", read_excel("wage_rate_1990.xlsx"))
dbWriteTable(con, "WageRate2000", read_excel("wage_rate_2000.xlsx"))
dbWriteTable(con, "WageRate2010", read_excel("wage_rate_2010.xlsx"))
dbWriteTable(con, "WageRate2020", read_excel("wage_rate_2020.xlsx"))

# Show which tables are stored in the WageRateDB database
dbListTables(con)

# Calculate the annual income by multiplying the wage rate by 40 working hours per week and 52 weeks per year
tbl(con, "WageRate2020") |> 
  mutate(
    AnnualIncome = WageRate*40*52
  )

tbl(con, "WageRate2020") |> 
  mutate(
    AnnualIncome = WageRate*40*52
  ) |> 
  show_query()

# Create the annual income using an SQL query
sql <- "
SELECT WageRate2020.*, (WageRate * 40.0) * 52.0 AS AnnualIncome
FROM WageRate2020
"
dbGetQuery(con, sql)

# Calculate the number of observations, average income, and average experience by gender
tbl(con, "WageRate2020") |> 
  group_by(Gender) |>
  summarize(
    Observations=n(),
    AverageIncome = mean(WageRate),
    AverageExperience = mean(Experience)
  )

# Calculate the number of observations, average income, and average experience by gender of individuals with more than 10 years of work experience
tbl(con, "WageRate2020") |> 
  group_by(Gender) |>
  filter(Experience > 10) |>
  summarize(
    Observations=n(),
    AverageIncome = mean(WageRate),
    AverageExperience = mean(Experience)
  )

# Compute the average income by experience level.
tbl(con, "WageRate2020") |> 
  group_by(Experience) |>
  summarize(
    AverageIncome = mean(WageRate),
  ) |>
  arrange(Experience)

# Merge data from multiple years (1990, 2000, 2010, and 2020) into one tibble and add a 'Year' column.
wage_rate = bind_rows(
  data.frame(Year="1990", tbl(con, "WageRate1990")), 
  data.frame(Year="2000", tbl(con, "WageRate2000")),
  data.frame(Year="2010", tbl(con, "WageRate2010")),
  data.frame(Year="2020", tbl(con, "WageRate2020")))

# Calculate the number of observations, average income, and average experience by gender and year
wage_rate |> 
  group_by(Year, Gender) |>
  summarize(
    Observations=n(),
    AverageIncome = mean(WageRate),
    AverageExperience = mean(Experience)
  )

# Repeat the previous step but sort by gender
wage_rate |> 
  group_by(Gender, Year) |>
  summarize(
    Observations=n(),
    AverageIncome = mean(WageRate),
    AverageExperience = mean(Experience)
  )

# Disconnect the database
dbDisconnect(con)

# END
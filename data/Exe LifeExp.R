# To delete the global environment: 
rm(list=ls())

# Load most used libraries:
library(ggplot2)
library(janitor)
library(usethis)
library(readxl)
library(openxlsx)
library(tidyverse)
library(tinytex)
library(googlesheets4)
library(DBI) # to connect to a database and then retrieve data with a SQL query
library(dbplyr)
library(duckdb)
library(patchwork) # combining plots

# To visualize all variables in each table
options(tibble.width=Inf)  

library(readr)
practice_problem_2_ <- read_csv("practice_problem (2).csv")
View(practice_problem_2_)

df <- practice_problem_2_
df

df = df |> 
  mutate(
    Value = as.numeric(Value)
  )
df
    
df_complete <- filter(df, !is.na(Value))
df_complete

wide <- df_complete |> 
    pivot_wider(
    id_cols = Country,
    names_from =  Variable,
    values_from = Value
    )
wide   
      
wide |> 
  group_by(Country) |> 
  count()

3. Calculate GDP per capita by creating a new column dividing GDP by Population.

wide = wide |> 
  mutate(
    GDP_per_capita = GDP/Population
  )
wide

# 4. Comment on the distribution of GDP and Population.


ggplot(data = wide, aes(x = Population, y = GDP))+
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE)

ggplot(wide, aes(y = GDP)) + 
  geom_boxplot() + 
  labs(
    title = "Distribution of GDP",
    y     = "GDP"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text.x = element_blank()
  ) +
  scale_y_continuous(labels = comma)
  
summary(wide$GDP)

ggplot(wide_data, aes(y = population)) + 
  geom_boxplot() + 
  labs(
    title = "Distribution of Population",
    y     = "GDP"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text.x = element_blank()
  ) +
  scale_y_continuous(
    labels = comma
  )

summary(wide_data$population)


# Determine the association between life expectancy, GDP per capita, and HDI using a 
#regression model. Treat life expectancy as the dependent variable.
colnames(wide)

summary(lm(Life_Expectancy ~ GDP_per_capita + HDI, data =  wide))

#6. Create scatter plots to examine the relationship between GDP per capita and life 
#expectancy and HDI and life expectancy.
colnames(wide)
ggplot(data = wide, aes(x = Life_Expectancy, y = GDP_per_capita))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  scale_y_continuous(limits = c(0, 0.001))

wide |>  
  filter(GDP_per_capita != max(GDP_per_capita, na.rm = TRUE)) |>
  ggplot(aes(x = GDP_per_capita, y = Life_Expectancy))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE) 



#7. Add regression lines to the scatterplots.


#8. Find the average HDI of all countries.
colnames(wide)
wide
wide |> 
  group_by(Country) |> 
  mutate(Ave_HDI = mean(HDI))


#9. Which country has the highest life expectancy?
wide |> 
  arrange(desc(Life_Expectancy))

wide |> 
  slice_max(Life_Expectancy, na_rm = TRUE)

# 10. How many countries have a life expectancy of more than 50?
wide |> 
  filter(Life_Expectancy > 50) |> 
  count()

wide |> 
  filter(Life_Expectancy > 50) |> 
  summarise(life_exp_more_than_50 = n())

# 11. Create a smaller dataset with 10 countries with the highest GDP per capita.
top10 <- wide |> 
  arrange(desc(GDP_per_capita)) 

top10
slice_head(top10, n=10)

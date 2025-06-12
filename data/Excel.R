
rm(list=ls())
install.packages("janitor")

library(readxl)
library(writexl)
library(tidyverse)
library(googlesheets4)
library(janitor)
library(readr)


library(readxl)
students <- read_excel("students.xlsx")
View(students)



students <- read_excel("data/students.xlsx")
students

students$`Student ID` 
# variable names with a space always cause problems somewhere
# use snake_case student_id or CamelCase StudentID
students$

library(readr)

students <- students |> 
  clean_names() 
students

students <- students |> 
  mutate(
    na = c("", "N/A"))

students
  
read_excel(
  "students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age")
)
# already better but shouldn't the old variable names be dropped
students <- students |> 
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age")

read_excel(
  "students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1
) 
# so far so good but there is an issue favourite_food as N/A should be NA. Happens often especially as people are not familiar with data analysis.

read_excel(
  "data/students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A") 
  # ... but why is age not numeric... I see five should be 5 so lets force data types on each columns
)
|> 

read_excel(
  "students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A"),
  col_types = c("numeric", "text", "text", "text", "numeric")
) 
# better but hasn't solved the issue completely as we know that five is 5

students <- read_excel(
  "data/students.xlsx",
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A"),
  col_types = c("numeric", "text", "text", "text", "text")
)
students

students |> 
  na = c("", "N/A")
students

students |>
  mutate(
    age = if_else(age == "five", "5", age),
  )
# five is 5 but age is still considered as a character


students <- students |>
  mutate(
    favourite_food = if_else (favourite_food == c("", "N/A")
    age = if_else(age == "five", "5", age),
    age = parse_number(age)
  )
students

students <- students |>
  mutate(
    age = if_else(age == "five", "5", age),
    age = parse_number(age)
  )
students # looks good

read_excel("data/penguins.xlsx", sheet = "Torgersen Island")
# data has incorrectly be stored in xlsx. NA is a str - not highlighted in red

penguins_torgersen <- read_excel("data/penguins.xlsx", sheet="Torgersen Island", na="NA")
penguins_torgersen

excel_sheets("data/penguins.xlsx")
# more sheets

penguins_biscoe <- read_excel("data/penguins.xlsx", sheet="Biscoe Island", na="NA")
penguins_biscoe

penguins_dream  <- read_excel("data/penguins.xlsx", sheet="Dream Island", na="NA")
penguins_dream

# let's concatenate the different sheets. Do they have the same dimension
dim(penguins_torgersen)
#> [1] 52  8
dim(penguins_biscoe)
#> [1] 168   8
dim(penguins_dream)
#> [1] 124   8

# Are the variables also the same
colnames(penguins_torgersen)
colnames(penguins_biscoe)
colnames(penguins_dream)

penguins <- bind_rows(penguins_torgersen, penguins_biscoe, penguins_dream)
penguins
#> # A tibble: 344 × 8
#>   species island    bill_length_mm bill_depth_mm flipper_length_mm
#>   <chr>   <chr>              <dbl>         <dbl>             <dbl>
#> 1 Adelie  Torgersen           39.1          18.7               181
#> 2 Adelie  Torgersen           39.5          17.4               186
#> 3 Adelie  Torgersen           40.3          18                 195
#> 4 Adelie  Torgersen           NA            NA                  NA
#> 5 Adelie  Torgersen           36.7          19.3               193
#> 6 Adelie  Torgersen           39.3          20.6               190
#> # ℹ 338 more rows
#> # ℹ 3 more variables: body_mass_g <dbl>, sex <chr>, year <dbl>

deaths_path <- readxl_example("deaths.xlsx")
deaths_path

deaths <- read_excel(deaths_path)
deaths
#> New names:
#> • `` -> `...2`
#> • `` -> `...3`
#> • `` -> `...4`
#> • `` -> `...5`
#> • `` -> `...6`
#> # A tibble: 18 × 6
#>   `Lots of people`    ...2       ...3  ...4     ...5          ...6           
#>   <chr>               <chr>      <chr> <chr>    <chr>         <chr>          
#> 1 simply cannot resi… <NA>       <NA>  <NA>     <NA>          some notes     
#> 2 at                  the        top   <NA>     of            their spreadsh…
#> 3 or                  merging    <NA>  <NA>     <NA>          cells          
#> 4 Name                Profession Age   Has kids Date of birth Date of death  
#> 5 David Bowie         musician   69    TRUE     17175         42379          
#> 6 Carrie Fisher       actor      60    TRUE     20749         42731          
#> # ℹ 12 more rows

read_excel(deaths_path, range="A5:F15") # defines where the variable names can be found
#> # A tibble: 10 × 6
#>   Name          Profession   Age `Has kids` `Date of birth`    
#>   <chr>         <chr>      <dbl> <lgl>      <dttm>             
#> 1 David Bowie   musician      69 TRUE       1947-01-08 00:00:00
#> 2 Carrie Fisher actor         60 TRUE       1956-10-21 00:00:00
#> 3 Chuck Berry   musician      90 TRUE       1926-10-18 00:00:00
#> 4 Bill Paxton   actor         61 TRUE       1955-05-17 00:00:00
#> 5 Prince        musician      57 TRUE       1958-06-07 00:00:00
#> 6 Alan Rickman  actor         69 FALSE      1946-02-21 00:00:00
#> # ℹ 4 more rows
#> # ℹ 1 more variable: `Date of death` <dttm>

bake_sale <- tibble(
  item     = factor(c("brownie", "cupcake", "cookie")),
  quantity = c(10, 5, 8)
)
bake_sale
#> # A tibble: 3 × 2
#>   item    quantity
#>   <fct>      <dbl>
#> 1 brownie       10
#> 2 cupcake        5
#> 3 cookie         8

write_xlsx(bake_sale, path="data/bake-sale.xlsx")

read_excel("data/bake-sale.xlsx")
#> # A tibble: 3 × 2
#>   item    quantity
#>   <chr>      <dbl>
#> 1 brownie       10
#> 2 cupcake        5
#> 3 cookie         8


data <- read_csv(
  "data/heights.csv"
)

data <- read_csv(
  "data/heights.csv",
  col_names = c("income", "height", "gender", "eductation", "age", "race"),
  skip = 1,
  col_types = "ddcddc",
  na = c("", "N/A")
)

data <- read.table(
  "data/heights.txt",
  sep = "\t", # change to "," or ";" if needed
  header = FALSE,
  skip = 1,
  col.names = c("income", "height", "gender", "eductation", "age", "race"),
  na.strings = c("", "N/A"),
  colClasses = c("numeric", "numeric", "character", "numeric", "numeric", "character"),
  stringsAsFactors = FALSE
)


gs4_deauth()
students_sheet_id <- "1V1nPp1tzOuutXFLb3G9Eyxi3qxeEhnOXUzL5_BcCQ0w"
# https://docs.google.com/spreadsheets/d/1V1nPp1tzOuutXFLb3G9Eyxi3qxeEhnOXUzL5_BcCQ0w
students <- read_sheet(students_sheet_id)
#> ✔ Reading from students.
#> ✔ Range Sheet1.

students
#> # A tibble: 6 × 5
#>   `Student ID` `Full Name`      favourite.food     mealPlan            AGE   
#>          <dbl> <chr>            <chr>              <chr>               <list>
#> 1            1 Sunil Huffmann   Strawberry yoghurt Lunch only          <dbl> 
#> 2            2 Barclay Lynn     French fries       Lunch only          <dbl> 
#> 3            3 Jayendra Lyne    N/A                Breakfast and lunch <dbl> 
#> 4            4 Leon Rossini     Anchovies          Lunch only          <NULL>
#> 5            5 Chidiegwu Dunkel Pizza              Breakfast and lunch <chr> 
#> 6            6 Güvenç Attila    Ice cream          Lunch only          <dbl>

students <- read_sheet(
  students_sheet_id,
  col_names = c("student_id", "full_name", "favourite_food", "meal_plan", "age"),
  skip = 1,
  na = c("", "N/A"),
  col_types = "dcccc"
)
#> ✔ Reading from students.
#> ✔ Range 2:10000000.

students
#> # A tibble: 6 × 5
#>   student_id full_name        favourite_food     meal_plan           age  
#>        <dbl> <chr>            <chr>              <chr>               <chr>
#> 1          1 Sunil Huffmann   Strawberry yoghurt Lunch only          4    
#> 2          2 Barclay Lynn     French fries       Lunch only          5    
#> 3          3 Jayendra Lyne    <NA>               Breakfast and lunch 7    
#> 4          4 Leon Rossini     Anchovies          Lunch only          <NA> 
#> 5          5 Chidiegwu Dunkel Pizza              Breakfast and lunch five 
#> 6          6 Güvenç Attila    Ice cream          Lunch only          6

penguins_sheet_id <- "1aFu8lnD_g0yjF5O-K6SFgSEWiHPpgvFCF0NY9D6LXnY"
# https://docs.google.com/spreadsheets/d/1aFu8lnD_g0yjF5O-K6SFgSEWiHPpgvFCF0NY9D6LXnY
read_sheet(penguins_sheet_id, sheet="Torgersen Island")


#> ✔ Reading from penguins.
#> ✔ Range ''Torgersen Island''.
#> # A tibble: 52 × 8
#>   species island    bill_length_mm bill_depth_mm flipper_length_mm
#>   <chr>   <chr>     <list>         <list>        <list>           
#> 1 Adelie  Torgersen <dbl [1]>      <dbl [1]>     <dbl [1]>        
#> 2 Adelie  Torgersen <dbl [1]>      <dbl [1]>     <dbl [1]>        
#> 3 Adelie  Torgersen <dbl [1]>      <dbl [1]>     <dbl [1]>        
#> 4 Adelie  Torgersen <chr [1]>      <chr [1]>     <chr [1]>        
#> 5 Adelie  Torgersen <dbl [1]>      <dbl [1]>     <dbl [1]>        
#> 6 Adelie  Torgersen <dbl [1]>      <dbl [1]>     <dbl [1]>        
#> # ℹ 46 more rows
#> # ℹ 3 more variables: body_mass_g <list>, sex <chr>, year <dbl>

sheet_names(penguins_sheet_id)
#> [1] "Torgersen Island" "Biscoe Island"    "Dream Island"

deaths_url <- gs4_example("deaths")
deaths <- read_sheet(deaths_url, range = "A5:F15")
#> ✔ Reading from deaths.
#> ✔ Range A5:F15.

deaths
#> # A tibble: 10 × 6
#>   Name          Profession   Age `Has kids` `Date of birth`    
#>   <chr>         <chr>      <dbl> <lgl>      <dttm>             
#> 1 David Bowie   musician      69 TRUE       1947-01-08 00:00:00
#> 2 Carrie Fisher actor         60 TRUE       1956-10-21 00:00:00
#> 3 Chuck Berry   musician      90 TRUE       1926-10-18 00:00:00
#> 4 Bill Paxton   actor         61 TRUE       1955-05-17 00:00:00
#> 5 Prince        musician      57 TRUE       1958-06-07 00:00:00
#> 6 Alan Rickman  actor         69 FALSE      1946-02-21 00:00:00
#> # ℹ 4 more rows
#> # ℹ 1 more variable: `Date of death` <dttm>


# END
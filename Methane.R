library(greenfeedr)
library(tidyverse)

rm(list=ls())
??greenfeedr

#Download data from C_LOCK
get_gfdata(user = "dairynz", 
           pass = "methane", 
           unit = c(333, 334, 335, 336), 
           start_date = "26/05/2025",
           end_date = "30/05/2025",
           save_dir = "data")

# Save data as csv
all <- read_csv("data/NA_GFdata.csv")
colnames(all)
tags <- all |> 
  select("AnimalName", "RFID")

# Intake per animal > set gcup(drop test value)
intake <- pellin(user = "dairynz", pass = "methane", unit = c(333, 334, 335, 336), 
       gcup = 34, start_date = "26/05/2025", end_date = "30/05/2025",
       save_dir = "data")

intake
colnames(intake)
# Intake per tag

Resume <- tags |> 
  left_join(all, join_by(RFID))
view(Resume)


visits <- viseat(user = "dairynz",
               pass = "methane",
               unit = c(3333, 334, 335, 336),
               start_date = "26/05/2025", 
               end_date = "30/05/2025"
               )
visits

pellet_intakes <- read_csv("data/pellet_intakes.csv")


colnames(pellet_intakes)
glimpse(pellet_intakes)
colnames(all)

view(intake)
view(all)

all = all |> 
  separate(StartTime, into = c("date", "time"), sep = " ")

allreduced <- all |> 
  select("AnimalName", "RFID", "date", "CO2GramsPerDay", "CH4GramsPerDay", "H2GramsPerDay")  
allreduced


animal <- allreduced |> 
  left_join(intake, join_by("RFID", "date" == "Date"))
animal


view(animal)

report <- report_gfdata(input_type = "PRELIM", 
              unit = c(333, 334, 335, 336), 
              start_date = "26/05/2025",
              end_date = "30/05/2025", 
              user = "dairynz", 

            
report_gfdata(
  user = "dairynz",
  pass = "methane",
  unit = c(333, 334, 335, 336), 
  start_date = "26/05/2025",
  end_date = "30/05/2025", 
  input_type = "prelim",
  save_dir = "/Users/Downloads/",
  plot_opt = "All")


getwd()
visit_data <- viseat (
              user = "dairynz",
              pass = "methane",
              unit = c(333, 334, 335, 336),
              start_date = "26/05/2025",
              end_date = "30/05/2025",
              )
               

view(visit_data)

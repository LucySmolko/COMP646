#GGPLOT SCATTERPLOT
# In ggplot2, there are three essential components that every plot must have:
# Data (data argument): This is the dataset used for the plot.
# Aesthetics (aes() function): Defines which variables are mapped to visual properties (axes, color, size, etc.).
# Geometries (geom_*() function): Defines how the data is visually represented (points, lines, bars, etc.).

# Load ggplot2
library(ggplot2)

#investigate the mtcars dataset
head(mtcars, n = 10)
tail(mtcars)

#learn more about the dataset
?mtcars

#learn about the structure of the dataset
str(mtcars)

#Let's plot the association between wt and mpg
# Create an empty plot specifying the dataset and aesthetics
ggplot(data = mtcars, aes(x = wt, y = mpg))

# Specify a geometric representation
ggplot(data = mtcars, aes(x = wt, y = mpg))+
  geom_point()

# Let's change the color and the size
ggplot(data = mtcars, aes(x = wt, y = mpg))+
  geom_point(color = 'blue', size = 3)

# What if we want to understand these associations for each cylinder value
ggplot(data = mtcars, aes(x = wt, y = mpg, color = cyl))+
  geom_point(size = 3)

# There is something not right about this picture
mtcars$cyl
glimpse(mtcars)
# Change cyl to a factor or a categorical variable
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)

# Add a line to the scatterplot to help visualize the data better
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm')

# Remove the standard errors
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)


# Add labels for better readability
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Cylinders')

# Center the title
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Cylinders')+
  theme(plot.title = element_text(hjust = 0.5))

# What if you wanted to study the associations for different cyl values
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Cylinders')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~cyl)

# What if you wanted to study the associations for different gear values
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(gear)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Gears')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~gear)

# Experiment with different themes
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(gear)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Gears')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_grid(~gear)+
  theme_dark()

library(ggthemes)

# How would you center the title while using theme_dark?
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(gear)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Gears')+
  facet_grid(~gear)+
  theme_dark()+
  theme(plot.title = element_text(hjust = 0.5, size = 20, face = "bold"))


# Make the axes labels and titles larger
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(gear)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Gears')+
  facet_grid(~gear)+
  theme_dark()+
  theme(plot.title = element_text(hjust = 0.5, size = 20, face = "bold"),
        axis.title = element_text(size = 16),
        axis.text = element_text(size = 12),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12))

GGPLOT DISTRIBUTION
# It is important to understand how data are distributed
# The histogram is one of the most fundamental ways to visualize a distribution.
# It shows the frequency of observations within bins.

# We can set the theme at the top for every graph
theme_set(theme_bw())

# Example: Distribution of Miles Per Gallon (mpg)
ggplot(data= mtcars, aes(x = mpg)) +
  geom_histogram()

ggplot(data= mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "blue", alpha = 0.2) 



# Add labels
ggplot(data= mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "blue", alpha = 0.2)+
  labs(title = "Histogram of MPG", x = "Miles Per Gallon", y = "Frequency")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# Interpretation?



# Density plot is another way to visualize the distribution of the data
ggplot(data= mtcars, aes(x = mpg)) +
  geom_density(fill = "blue", color = "blue", alpha = 0.2)+
  labs(title = "Density plot of MPG", y = "Density", x = "Miles Per Gallon")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# Box plot provides a summary of the distribution
ggplot(data= mtcars, aes(y = mpg)) +
  geom_boxplot(fill = "blue", color = "blue", alpha = 0.7)+
  labs(title = "Box plot of MPG", y = "Miles Per Gallon")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18),
        axis.text.x = element_blank())



# Compare the distributions of MPG for different levels of cylinders
# Box plots are quite useful
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  labs(title = "MPG Distribution by Cylinder Count", x = "Cylinders", y = "Miles Per Gallon")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# Give each box plot a different color (for illustrative purposes)
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(title = "MPG Distribution by Cylinder Count", x = "Cylinders", y = "Miles Per Gallon")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# How do you change the title of the legend?
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  labs(title = "MPG Distribution by Cylinder Count", x = "Cylinders", y = "Miles Per Gallon", fill = "Cylinders")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# We can also compare the distributions using density functions
ggplot(mtcars, aes(x = mpg, fill = as.factor(cyl)))+
  geom_density()

# The above is not very informative
ggplot(mtcars, aes(x = mpg, fill = as.factor(cyl)))+
  geom_density(alpha = 0.5)+
  labs(title = "MPG Density Plot by Cylinder Count", x = "Miles Per Gallon", y = "Density", fill = "Cylinders")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# Sometimes it's useful to combine a histogram with a density plot for more insights.      
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(aes(y = ..density..), binwidth = 2, fill = "gray", color = "black", alpha = 0.5) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram and Density Overlay of MPG", x = "Miles Per Gallon", y = "Density")

# Now let's plot the empirical cumulative distribution
ggplot(mtcars, aes(x = mpg)) +
  stat_ecdf(geom = "step") + # you can try different geoms: line, point, for example. 
  labs(title = "Empirical cumulative distribution of MPG", x = "Miles Per Gallon", y = "Cumulative Probability")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))

# Count the number of cars by cylinders
ggplot(data = mtcars, aes(x = as.factor(cyl)))+
  geom_bar()+
  labs(x= "Number of cylinders")

ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl))) +
  geom_bar() +
  labs(title = "Number of Cars by Cylinder Type", x = "Number of Cylinders", y = "Count", fill = "Cylinder")
GGPLOT 
# Short review of last week
# Scatterplot

# We created this scatterplot
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Cylinders')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~cyl)

# What if we want to change the colors?
# Use scale_color_manual
ggplot(data = mtcars, aes(x = wt, y = mpg, color = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       color = 'Cylinders')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~cyl)+
  scale_color_manual(values = c("pink", "purple", "orange"))





# Sometimes you will be asked to create graphs in black and white
# We are already using theme_bw
# We can change color to shape

ggplot(data = mtcars, aes(x = wt, y = mpg, shape = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE, color = "black")+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       shape = 'Cylinders')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~cyl)


# Can you change the shapes manually?

ggplot(data = mtcars, aes(x = wt, y = mpg, shape = as.factor(cyl)))+
  geom_point(size = 3)+
  geom_smooth(method = 'lm', se = FALSE, color = "black")+
  labs(title = 'Fuel Efficiency vs. Weight',
       x = 'Car Weight (1000s lbs)',
       y = 'Miles Per Gallon',
       shape = 'Cylinders')+
  theme(plot.title = element_text(hjust = 0.5))+
  facet_wrap(~cyl)




# We made box plots
ggplot(data= mtcars, aes(y = mpg)) +
  geom_boxplot(fill = "blue", color = "blue", alpha = 0.3, outlier.alpha = 1, outlier.size = 2)+
  labs(title = "Box plot of MPG", y = "Miles Per Gallon")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18),
        axis.text.x = element_blank())




# Now let's plot the empirical cumulative distribution
ggplot(mtcars, aes(x = mpg)) +
  stat_ecdf(geom = "step") + # you can try different geoms: line, point, for example. 
  labs(title = "Empirical cumulative distribution of MPG", x = "Miles Per Gallon", y = "Cumulative Probability")+
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 18))



# Count the number of cars by cylinders
ggplot(data = mtcars, aes(x = as.factor(cyl)))+
  geom_bar()+
  labs(x= "Number of cylinders")

# Add some color
ggplot(mtcars, aes(x = factor(cyl))) +  
  geom_bar(fill = "steelblue", color = "black") +  
  labs(title = "Number of Cars by Cylinder Count",
       x = "Number of Cylinders",
       y = "Count")




# Let's create a stacked bar chart
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(gear))) +  
  geom_bar() +  
  labs(title = "Stacked Bar Chart of Transmission by Cylinder Count",
       x = "Number of Cylinders",
       y = "Count",
       fill = "Gears")+
  scale_fill_manual(values = c("3" = "red", "4" = "green", "5" = "blue")) 


# Grouped bar chart / side-by-side
ggplot(mtcars, aes(x = factor(cyl), fill = factor(gear))) +  
  geom_bar(position = "dodge") +  
  labs(title = "Grouped Bar Chart of Gears by Cylinder Count",
       x = "Number of Cylinders",
       y = "Count",
       fill = "Gears") +  
  scale_fill_manual(values = c("3" = "red", "4" = "green", "5" = "blue"))

# What if you want this in b&w

# Stacked bar chart with different line patterns
ggplot(mtcars, aes(x = factor(cyl), fill = factor(gear))) +  
  geom_bar(color = "black", position = "stack") +
  scale_fill_manual(values = c(
    "3" = "grey20", 
    "4" = "grey50",  
    "5" = "gray80"  
  )) +
  labs(title = "Stacked Bar Chart with Line Patterns",
       x = "Number of Cylinders",
       y = "Count",
       fill = "Gears") 


# Stacked bar chart with different grey shades and change the width
ggplot(mtcars, aes(x = factor(cyl), fill = factor(gear))) +  
  geom_bar(color = "black", position = "stack", width = 0.8) +
  scale_fill_grey(start = 0.2, end = 0.8) +
  labs(title = "Stacked Bar Chart with Line Patterns",
       x = "Number of Cylinders",
       y = "Count",
       fill = "Gears") 



#Stacked bar chart with percentages
ggplot(mtcars, aes(x = factor(cyl), fill = factor(gear))) +  
  geom_bar(position = "fill", color = "black") +  
  scale_y_continuous(labels = scales::percent_format()) +
  labs(title = "Stacked Bar Chart of Gears by Cylinder Count (Percentage)",
       x = "Number of Cylinders",
       y = "Percentage",
       fill = "Gears") 

# ggsave() saves the plot most recently created to disk
ggsave("C:\\Users\\vatsap\\OneDrive\\stacked_with_percentages.png", width = 8, height = 6, dpi = 600)


# grammar of graphics -----------------------------------------------------

mpg

?mpg

# how many classes are there?


mpg |> 
  distinct(class)


ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()


ggplot(mpg, aes(x = displ, y = hwy, shape = class)) +
  geom_point()

# what do you observe?

# not a good idea to have many shapes on a graph
# and R lets you know!

ggplot(mpg, aes(x = displ, y = hwy, size = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) +
  geom_point()

# what do you observe?

# not good charts

# assign color inside the geom function to change the color
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "blue")


# using different geometric objects or geoms
# same data but different geoms

# scatter plot
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

# line chart
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth()

# we can set different types of lines but not shapes

ggplot(mpg, aes(x = displ, y = hwy, shape = drv)) + 
  geom_smooth()


ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) + 
  geom_smooth()

# we can the raw data and the lines on the same chart...with color!
# leave no doubt about what somebody is looking at!

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + 
  geom_point() +
  geom_smooth(aes(linetype = drv))

# placing mappings within geoms

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) + # a different color for each class
  geom_smooth() # one curve through the entire data

# # use  different data for each layer
# use red points as well as open circles to highlight two-seater cars. The 
# local data argument in geom_point() overrides the global data argument in ggplot() for that layer only.

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    color = "red"
  ) +
  geom_point(
    data = mpg |> filter(class == "2seater"), 
    shape = "circle open", size = 3, color = "red"
  )
diamonds

?diamonds

# count occurrences of each category in cut
ggplot(diamonds, aes(x = cut)) + 
  geom_bar()

# count it yourself using the count function and then plot it
diamonds |> 
  count(cut) |> 
  ggplot(aes(x = cut, y = n)) +  # you need to specify the variable along the y axis
  geom_bar(stat = "identity")  # use raw values of y

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + 
  geom_bar()

ggplot(diamonds) + 
  stat_summary(
    aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# outline of the bars
ggplot(mpg, aes(x = drv, color = drv)) + 
  geom_bar()

# fill colors
ggplot(mpg, aes(x = drv, fill = drv)) + 
  geom_bar()

# what if you want to stack look at class within the drv?
ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar()

mpg |> 
  group_by(class)
# which argument should we use to make the bars more transparent?


ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(alpha = 0.5)


# look at the proportions of classes for each drive train
ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(position = "fill")

# look at counts for each class side by side for each drive train
ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(position = "dodge")

diamonds2 |> 
  count(color, cut) |> 
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n))


# combining plots
# install.packages("patchwork")
library(patchwork)

p1 <- ggplot(mpg, aes(x = drv, y = cty, color = drv)) + 
  geom_boxplot(show.legend = FALSE) + 
  labs(title = "Plot 1")

p1

p2 <- ggplot(mpg, aes(x = drv, y = hwy, color = drv)) + 
  geom_boxplot(show.legend = FALSE) + 
  labs(title = "Plot 2")

p2

p3 <- ggplot(mpg, aes(x = cty, color = drv, fill = drv)) + 
  geom_density(alpha = 0.5) + 
  labs(title = "Plot 3")

p3

p4 <- ggplot(mpg, aes(x = hwy, color = drv, fill = drv)) + 
  geom_density(alpha = 0.5) + 
  labs(title = "Plot 4")

p4

p5 <- ggplot(mpg, aes(x = cty, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  facet_wrap(~drv) +
  labs(title = "Plot 5")

p5


p1+p2

p1/p2

(p1 + p2) / (p3 + p4) / p5

(p1 + p2) / (p3 + p4)

(p1 / p2) / (p3 + p4)

(guide_area()/(p1 / p2) / (p3 + p4))

(guide_area() / (p1 + p2) / (p3 + p4) / p5) +
  plot_annotation(
    title = "City and highway mileage for cars with different drive trains",
    caption = "Source: https://fueleconomy.gov."
  ) +
  plot_layout(
    guides = "collect",
    heights = c(1, 3, 2, 4)
  ) &
  theme(legend.position = "top")


label_info <- mpg |>
  group_by(drv) |>
  arrange(desc(displ)) |>
  slice_head(n = 1) |>  # takes the first row from each group
  mutate(
    drive_type = case_when(
      drv == "f" ~ "front-wheel drive",
      drv == "r" ~ "rear-wheel drive",
      drv == "4" ~ "4-wheel drive"
    )
  ) |>
  select(displ, hwy, drv, drive_type)

label_info


ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) +
  geom_text(
    data = label_info, 
    aes(x = displ, y = hwy, label = drive_type),
    fontface = "bold", size = 2, hjust = "right", vjust = "bottom"
  ) +
  theme(legend.position = "none")

library(ggrepel)

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) +
  geom_label_repel(
    data = label_info, 
    aes(x = displ, y = hwy, label = drive_type),
    fontface = "bold", size = 3, nudge_y = 3
  ) +
  theme(legend.position = "none")

# Annotating specific points on scatterplots
potential_outliers <- 
  mpg |>
  filter(hwy > 40 | (hwy > 20 & displ > 5))

potential_outliers

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") +
  geom_text_repel(data = potential_outliers, aes(label = model)) +
  geom_point(data = potential_outliers, color = "red") +
  geom_point(
    data = potential_outliers,
    color = "red", size = 3, shape = "circle open"
  ) 



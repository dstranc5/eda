# Exploratory data analysis (see readme for more detail)
# Feel free to follow these steps, or complete your own EDA

# Set up (install packages if you don't have them)
install.packages("ggplot2")
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(vioplot)
setwd('~/Documents/info-370/eda/health-burden/')
risk.data <- read.csv('./data/prepped/risk-data.csv', stringsAsFactors = FALSE) 

######################
### Data Structure ###
######################

## Using a variety of functions, investigate the structure of your data, such as:
# Dimensions, column names, structure, summaries, etc.
df <- data.frame(risk.data)
df$country
dim(df)
colnames(df)
str(df)
summary(df)
View(df)
# Replacing missing values...?

###########################
### Univariate Analysis ###
###########################

## Using a variety of approaches, investigate the structure each (risk column) individually

# Summarize data
View(df %>% filter(alcohol.use < 0))
# Create histograms, violin plots, boxplots
hist(df$alcohol.use)
hist(df$smoking)
ggplot(data = df, aes(df$alcohol.use)) + geom_histogram()
ggplot(data = df, aes(df$high.meat)) + geom_histogram()

####################################
### Univariate Analysis (by age) ###
####################################

# Investiage how each risk-variable varies by **age group**
# Create histograms, violin plots, boxplots. Calculate values as needed. 
ggplot(data = df, aes(x = age)) + geom_histogram()

####################################
### Univariate Analysis (by sex) ###
####################################

# Investiage how each risk-variable varies by **sex**

# Compare male to female values -- requires reshaping (and dropping population)!


########################################
### Univariate Analysis (by country) ###
########################################

## Investiage how each risk-variable varies by **country**

# Aggregate by country

# Create a choropleth map (see https://plot.ly/r/choropleth-maps/)
df$hover <- with(df, paste(country, '<br>', "Alcohol Consumption", alcohol.use))
# give state boundaries a white border
l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)

p <- plot_geo(df) %>%
  add_trace(
    z = ~df$alcohol.use, color = ~df$alcohol.use, colors = 'Blues',
    text = ~df$country, locations = ~df$country.code, marker = list(line = l)
  ) %>%
  colorbar(title = 'Alcohol Consumption around the World', tickprefix = '$') %>%
  layout(
    title = 'World Alcohol Consumption<br>Source:<a href="http://ghdx.healthdata.org/record/global-burden-disease-study-2015-gbd-2015-population-estimates-1970-2015">World Data</a>',
    geo = g
  )
p

###########################
### Bivariate Analysis ####
###########################

# Compare risks-variables to one another (visually)

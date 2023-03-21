
library(lubridate)
library(tidyverse)
library(magrittr)

#Loading the data ####

raw_dataset <- read.table(file = "./data/household_power_consumption.txt",
                          header = TRUE,
                          sep = ';',
                          stringsAsFactors = FALSE ,
                          na.strings = "?",
                          nrows = 2075259, 
                          check.names = FALSE,
                          colClasses = c(character(),
                                         character(),
                                         numeric(),
                                         numeric(),
                                         numeric(),
                                         numeric(),
                                         numeric(),
                                         numeric(),
                                         numeric()))



# Manipulating Data ####

# Converting the Date column into the Date class object and Filtering the observations
df_tidy <- raw_dataset %>%
  
  # Merging Date and Time POSIXlt.
  mutate(Time = strptime(paste(Date, " " ,Time), "%d/%m/%Y %H:%M:%S")) %>%
  
  # Converging character into Date.
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  
  # Filtering observations between 2007-02-01 and 2007-02-02.
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Exporting the PNG file ####
png(filename = "./plot2.png",
    width = 480 ,
    height = 480,
    units = "px",
    bg = "white")

# Forcing to printing in English.
Sys.setlocale("LC_TIME", "English")

# Plotting the Graphic
plot(df_tidy$Time,
     df_tidy$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kW)")

dev.off()
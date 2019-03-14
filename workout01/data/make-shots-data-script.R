
#####
# title: make-shots-data-script
# description: Tidies up and summarizes the data files of the shots data from different players on the GSW team
# input: stephen-curry.csv, andre-iguodala.csv, draymond-green.csv, kevin-durant.csv, klay-thompson.csv
# output: github_document
#####

library(dplyr)

data_types <- c("character", "character", "factor", "integer", "integer", "integer", "factor", "factor", "factor", "integer", "character", "integer", "integer")
curry <- read.csv("../ifc090/workout01/data/stephen-curry.csv", colClasses = data_types, stringsAsFactors = FALSE)
iguodala <- read.csv("../ifc090/workout01/data/andre-iguodala.csv", colClasses = data_types, stringsAsFactors = FALSE)
green <- read.csv("../ifc090/workout01/data/draymond-green.csv", colClasses = data_types, stringsAsFactors = FALSE)
durant <- read.csv("../ifc090/workout01/data/kevin-durant.csv", colClasses = data_types, stringsAsFactors = FALSE)
thompson <- read.csv("../ifc090/workout01/data/klay-thompson.csv", colClasses = data_types, stringsAsFactors = FALSE)

curry <- mutate(curry, player = "Stephen Curry")
iguodala <- mutate(iguodala, player = "Andre Iguodala")
green <- mutate(green, player = "Draymond Green")
durant <- mutate(durant, player = "Kevin Durant")
thompson <- mutate(thompson, player = "Klay Thompson")


levels(curry$shot_made_flag) <- c(levels(curry$shot_made_flag), "shot_yes")
curry$shot_made_flag[curry$shot_made_flag == 'y'] <- "shot_yes"
levels(curry$shot_made_flag) <- c(levels(curry$shot_made_flag), "shot_no")
curry$shot_made_flag[curry$shot_made_flag == 'n'] <- "shot_no"


levels(iguodala$shot_made_flag) <- c(levels(iguodala$shot_made_flag), "shot_yes")
iguodala$shot_made_flag[iguodala$shot_made_flag == 'y'] <- "shot_yes"
levels(iguodala$shot_made_flag) <- c(levels(iguodala$shot_made_flag), "shot_no")
iguodala$shot_made_flag[iguodala$shot_made_flag == 'n'] <- "shot_no"


levels(green$shot_made_flag) <- c(levels(green$shot_made_flag), "shot_yes")
green$shot_made_flag[green$shot_made_flag == 'y'] <- "shot_yes"
levels(green$shot_made_flag) <- c(levels(green$shot_made_flag), "shot_no")
green$shot_made_flag[green$shot_made_flag == 'n'] <- "shot_no"


levels(durant$shot_made_flag) <- c(levels(durant$shot_made_flag), "shot_yes")
durant$shot_made_flag[durant$shot_made_flag == 'y'] <- "shot_yes"
levels(durant$shot_made_flag) <- c(levels(durant$shot_made_flag), "shot_no")
durant$shot_made_flag[durant$shot_made_flag == 'n'] <- "shot_no"


levels(thompson$shot_made_flag) <- c(levels(thompson$shot_made_flag), "shot_yes")
thompson$shot_made_flag[thompson$shot_made_flag == 'y'] <- "shot_yes"
levels(thompson$shot_made_flag) <- c(levels(thompson$shot_made_flag), "shot_no")
thompson$shot_made_flag[thompson$shot_made_flag == 'n'] <- "shot_no"


curry <- mutate(curry, minute = (minutes_remaining + 12*(period-1)))
iguodala <- mutate(iguodala, minute = (minutes_remaining + 12*(period-1)))
green <- mutate(green, minute = (minutes_remaining + 12*(period-1)))
durant <- mutate(durant, minute = (minutes_remaining + 12*(period-1)))
thompson <- mutate(thompson, minute = (minutes_remaining + 12*(period-1)))

sink(file = '../ifc090/workout01/output/andre-iguodala-summary.txt')
summary(iguodala)
# closing sinking operation
sink()

sink(file = '../ifc090/workout01/output/stephen-curry-summary.txt')
summary(curry)
# closing sinking operation
sink()

sink(file = '../ifc090/workout01/output/kevin-durant-summary.txt')
summary(durant)
# closing sinking operation
sink()

sink(file = '../ifc090/workout01/output/draymond-green-summary.txt')
summary(green)
# closing sinking operation
sink()

sink(file = '../ifc090/workout01/output/klay-thompson-summary.txt')
summary(thompson)
# closing sinking operation
sink()

shots_data <- rbind(curry, iguodala, durant, green, thompson)

write.csv(
  x = shots_data,
  file = '../ifc090/workout01/data/shots-data.csv'  
)

sink(file = '../ifc090/workout01/output/shots-data-summary.txt')
summary(shots_data)
# closing sinking operation
sink()




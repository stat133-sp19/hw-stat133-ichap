Workout 1
================
Isaac Chap

Golden State Warriors Shots Analysis Project
============================================

(Using R and Git)
-----------------

#### Introduction

The aim of this project is to use RStudio as well as some Git Terminal codes to utilize and manipulate raw data files to create dynamic graphics that helps visualize the data. This is important because looking at raw data files in textEdit or even excel can be unattractive, as it is both tedious and hard to look at such files and make any meaningful conclusions. Thus, using a software dedicated to software manipulation such as RStudio, we can create visually appealing graphics in various forms to convey the data that is relevant to the audience, either the team managers of Golden State Warriors themselves, or even just an avid NBA or basketball fan.

#### Motivation

NBA is a very popular sport in the US and across the globe even, and while watching the sport itself is a joy in itself, fans who are more analytical or intellectually curious could be wondering the various stats of these players. Because it is such a saturated sport with many aspects to each game and player, there is an abundance of stats that can be overwhelming to the average reader. Thus, this project looks at some specific variables and stats of five specific players on the Golden State Warriors team, Stephen Curry, Kevin Durant, Klay Thompson, Andre Iguodala and Draymond Green. In particular, we would be looking at various statistics of all the shots that these players made in the 2016 season.

#### Background

Golden State Warriors is a professional basketball team that is based in oakland, California. Though, it has relocated to San Francisco since 1962, therefore changing its name to 'Golden State' with reference to the iconic golden gate bridge. It is one of the most popular teams due to its location, resources and the professional players that have been on the team. Stephen Curry and Kevin Durant for instance are two of the most prolific players of this generation, and As a sport, basketball has been around the US for a long time, and it is definitely a culturally defining sport, as most youths and teens play and/or watch this sport as a result of NBA culture.

#### Data

This project started off with 5 raw data files found on stats 133 (Berkeley R computational class) GitHub: Stephen Curry, Kevin Durant, Klay Thompson, Andre Iguodala and Draymond Green '.csv' files that shows their shots-making statistics in the 2016 season. These raw data files contain all the data that needs to be used to create the graphics in this project. The first step to cleaning the data was importing into RStudio using the read.csv function. Because the data types were not ideal, I made a vector specifying the types for each column and implemented it into the read.csv function.

``` r
# data_types <- c("character", "character", "factor", "integer", "integer", "integer", "factor", "factor", "factor", "integer", "character", "integer", "integer")
# curry <- read.csv("../ifc090/hw-stat133/workout01/data/stephen-curry.csv", colClasses = data_types, stringsAsFactors = FALSE)
```

The next part is 3 separate manipulations of the data set. Firstly, because this data set was to be combined with the other data sets to create one easier to mainpulate data set, names of the player had to be added. Then, one of the variables "shot\_types" had factor data types that was either y (yes) or n (no), but since it was ambiguous what 'y' or 'n' meant it had to be changed into shot\_yes and shot\_no using the code below, making use of the levels function.

``` r
# levels(curry$shot_made_flag) <- c(levels(curry$shot_made_flag), "shot_yes")
# curry$shot_made_flag[curry$shot_made_flag == 'y'] <- "shot_yes"
# levels(curry$shot_made_flag) <- c(levels(curry$shot_made_flag), "shot_no")
# curry$shot_made_flag[curry$shot_made_flag == 'n'] <- "shot_no"  
```

Finally, to have a single variable that indicates when exactly a shot is made, we could use the columns period and minutes/seconds\_remaining to help us find the exact timestamp using the simple formula below:

    # curry <- mutate(curry, minute = (minutes_remaining + 12*(period-1)))

It is good to summarize these data sets and a quick summary provided by the data package dplyr allows us to use the sink function in conjuction with summary to create a comprehensive summary. Finally, these 5 data sets are combined into one single data set that is 'shots\_data'.

#### Analysis

A simple and ingenious way to visualize the data was to find an image of the standard basketball shot, and with the x and y coordinates data create an image that represents all the shots that were taken by each individual player, color coded by whether it misses or makes it in. Below is the chunk of code that imports the image of the basketball court that is the base of the graph of all the shots, and the code (using ggplot2) that plots all the data points onto the basketball court 'graph'.

``` r
# court_file <- "../ifc090/hw-stat133/workout01/images/nba-court.jpg"
# court_image <- rasterGrob(
#   readJPEG(court_file),
#   width = unit(1, "npc"),
#   height = unit(1, "npc"))
# 
# 
# iguodala_shot_chart <- ggplot(data = iguodala) +
#   annotation_custom(court_image, -250, 250, -50, 420) +
#   geom_point(aes(x = x, y = y, color = shot_made_flag)) +
#   ylim(-50, 420) +
#   ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
#   theme_minimal()
# ggsave("../ifc090/hw-stat133/workout01/images/andre-iguodala-shot-chart.pdf", width=6.5, height=5)
```

Below is the image of all 5 players and the shots they have made in the 2016 season. \[Shot charts for GSW players\] (<https://raw.githubusercontent.com/ichap/workout01-isaac-chap/master/workout01/images/gsw-shot-chart.png>) <img src="../../../../ifc090/hw-stat133/workout01/images/gsw-shot-chart.png" width="80%" style="display: block; margin: auto;" />

#### Discussion

Another way to look at the data set was through separating the shots that were 2 pointers and 3 pointers. This was simple to look at, but it required some extra manipulation of the data. By using dplyr data package once again, you can create a summary (in the form of a table) that shows the total shots attempted, shots that made it in, and the accuracy in percentage of each player. This is shown in the code below:

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
shots_data <- read.csv("../../../../ifc090/hw-stat133/workout01/data/shots-data.csv")

two_pt <- summarise(
  group_by(filter(shots_data, shot_type == "2PT Field Goal"), player), total = n(), made = sum(shot_made_flag == "shot_yes"), perc_made = made/total*100)
two_pt
```

    ## # A tibble: 5 x 4
    ##   player         total  made perc_made
    ##   <fct>          <int> <int>     <dbl>
    ## 1 Andre Iguodala   210   134      63.8
    ## 2 Draymond Green   346   171      49.4
    ## 3 Kevin Durant     643   390      60.7
    ## 4 Klay Thompson    640   329      51.4
    ## 5 Stephen Curry    563   304      54.0

``` r
three_pt <- summarise(
  group_by(filter(shots_data, shot_type == "3PT Field Goal"), player), total = n(), made = sum(shot_made_flag == "shot_yes"), perc_made = made/total*100)
three_pt
```

    ## # A tibble: 5 x 4
    ##   player         total  made perc_made
    ##   <fct>          <int> <int>     <dbl>
    ## 1 Andre Iguodala   161    58      36.0
    ## 2 Draymond Green   232    74      31.9
    ## 3 Kevin Durant     272   105      38.6
    ## 4 Klay Thompson    580   246      42.4
    ## 5 Stephen Curry    687   280      40.8

``` r
overall <- summarise(
  group_by(shots_data, player), total = n(), made = sum(shot_made_flag == "shot_yes"), perc_made = made/total*100)
overall
```

    ## # A tibble: 5 x 4
    ##   player         total  made perc_made
    ##   <fct>          <int> <int>     <dbl>
    ## 1 Andre Iguodala   371   192      51.8
    ## 2 Draymond Green   578   245      42.4
    ## 3 Kevin Durant     915   495      54.1
    ## 4 Klay Thompson   1220   575      47.1
    ## 5 Stephen Curry   1250   584      46.7

#### Conclusion

By selecting the data types that are relevant, you can create powerful graphics that can help visualize the variables in a data set. Originally, we had data sets of sice 1250 rows and 13 columns, but using various methods user friendly representations of the data is realized.

#### References

\[Golden State Warriors\] (<https://en.wikipedia.org/wiki/Golden_State_Warriors>)

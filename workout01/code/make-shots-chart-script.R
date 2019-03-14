
#####
# title: make-shots-chart-script
# description: Creates shots charts from the player's data
# input: shots_data, curry, durant, iguodala, thompson, green
# output: github_document
#####

library(ggplot2)
library(jpeg)
library(grid)


shots_data <- read.csv("../ifc090/workout01/data/shots-data.csv")


# court image (to be used as background of plot)
court_file <- "../ifc090/workout01/images/nba-court.jpg"
# create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

# shot chart with court background

iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
ggsave("../ifc090/workout01/images/andre-iguodala-shot-chart.pdf", width=6.5, height=5)

curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
ggsave("../ifc090/workout01/images/stephen-curry-shot-chart.pdf", width=6.5, height=5)


durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
ggsave("../ifc090/workout01/images/kevin-durant-shot-chart.pdf", width=6.5, height=5)

thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
ggsave("../ifc090/workout01/images/klay-thompson-shot-chart.pdf", width=6.5, height=5)

green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
ggsave("../ifc090/workout01/images/draymond-green-shot-chart.pdf", width=6.5, height=5)

gsw_shots_chart <- ggplot(data = shots_data) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  ylim(-50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ggtitle('Shot Chart of GSW (2016 season)') +
  theme_minimal() +
  facet_wrap(~ player)
ggsave("../ifc090/workout01/images/gsw-shot-chart.pdf", width=8, height=7)
ggsave("../ifc090/workout01/images/gsw-shot-chart.png", width=8, height=7)




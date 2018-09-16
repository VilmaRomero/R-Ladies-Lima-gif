library(gganimate)
library(ggplot2)
library(dplyr)

# Creating "R Ladies" text from scratch
rladies <- data.frame(x = c(rep(1:6,c(7,7,3,4,6,3)),
                            rep(10:15,c(7,7,2,2,2,2)),
                            rep(17:22,c(1,4,3,3,5,4)),
                            rep(24:29,c(2,4,2,2,7,7)),
                            rep(31:34,c(2,5,5,1)),
                            rep(36:41,c(3,5,3,3,4,2)),
                            rep(43:48,c(2,4,3,3,4,2))),
                      y = c(rep(2:8,2),4,5,8,3:5,8,2,3,5:8,2,6,7,
                            rep(2:8,2),rep(2:3,4),
                            3,2:4,6,rep(c(2,4,6),2),2:6,2:5,
                            3:4,2:5,rep(c(2,5),2),rep(2:8,2),
                            2,5,rep(c(2:5,7),2),2,
                            3:5,2:6,rep(c(2,4,6),2),2,4:6,4:5,
                            2,5,2,4:6,rep(c(2,4,6),2),2:4,6,3,6))

ggplot(rladies, aes(x, y)) + 
  geom_tile(width = 0.9, height = 0.9)

# Creating "Lima" text from scratch
lima <- data.frame(x = c(rep(1:6,c(7,7,2,2,2,2)),
                         rep(8:11,c(2,5,5,1)),
                         rep(13:19,c(5,5,2,3,3,5,4)),
                         rep(21:26,c(1,4,3,3,5,4))),
                   y = c(rep(2:8,2),rep(2:3,4),
                         2,5,rep(c(2:5,7),2),2,
                         rep(2:6,2),4:5,3:5,4:6,2:6,2:5,
                         3,2:4,6,rep(c(2,4,6),2),2:6,2:5))

ggplot(lima, aes(x, y)) + 
  geom_tile(width = 0.9, height = 0.9)

# Joining all the information (R Ladies Lima)
plot_df <- dplyr::bind_rows(
  rladies %>% mutate(idx = 1),
  lima %>% mutate(idx = 2))

# Complete plot without the animation
p <- ggplot(plot_df, aes(x, y)) + 
  geom_tile(width = 0.9, height = 0.9, fill = "#88398A", colour = "black") + 
  labs(x = "", y = "")
  coord_equal() +
  theme_void()

# How will look if we separate the text  
# p +  facet_wrap(~idx) + theme_minimal() 

# Animating the plot  
panim <- p +
  transition_states(
    states            = idx, # variable in data
    transition_length = 1,   # all states display for 1 time unit
    state_length      = 1    # all transitions take 1 time unit
  ) +
  enter_fade() +             # How new blocks appear
  exit_fade() +              # How blocks disappear
  ease_aes('sine-in-out')    # Tweening movement
# panim

animate(panim, fps=20, nframes=50, width=1000, height=200)
anim_save("RLadiesLima.gif")

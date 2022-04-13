library(readr)
world <- read_csv("world.csv")
#not using fancy ggplot, just a quick peek.
plot(world$tick,world$bcount,type = "l")
plot(world$tick,world$fcount,type = "l")
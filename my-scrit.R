library(tidyverse)

our_data <- mtcars

our_data %>% 
ggplot(
  aes(
    x = cyl,
    y = hp
  )
  ) +
  geom_point()


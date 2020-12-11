library(tidyverse)

needle_data <- read_csv("needle_data.csv")


ggplot(needle_data, aes(x = needle_type, y = stitches)) +
  geom_violin() +
  facet_wrap(vars(needle_material), nrow = 2)

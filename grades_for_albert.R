# Albert showed me a simple task in Excel using Visual Basic, and I
# wanted to show him how to do the same thing with R - it's assigning
# grades "Pass", "Fail", and "Outstanding" to test scores. The test 
# scores are 100 randomly generated integers between zero and 100; the
# thresholds for pass and outstanding are 50 and 70 respectively.


scores <- sample(0:100, size = 100, replace = TRUE) 
# sample is similar to RANDBETWEEN()

grades <- character(length = length(scores)) 
# sets an empty vector the same length as scores

for (i in seq_along(scores)) { 
  if (scores[i] < 50) {
    grades[i] <- "Fail"
  } else if (scores[i] >= 50 & scores[i] < 70) {
    grades[i] <- "Pass"
  } else if (scores[i] >= 70) {
    grades[i] <- "Outstanding!"
  }
} # for loop with a couple of if statements to create vector of grades

results <- data.frame(scores = scores, grades = grades)
# combine the two vectors into one data frame (like an array or table in Excel)


# Using base R is messy, so I would use some functions from the dplyr package
# instead (dplyr is part of the tidyverse package too)

library(dplyr)

tidyresults <- tibble(scores = scores)
# this sets a tibble (or tbl - which is an improved data frame) with just
# one column - scores

# now we'll change the tbl by adding the grades column:

tidyresults <- 
  tidyresults %>% 
  mutate(
    grades = case_when(
      scores < 50             ~ "Fail", 
      between(scores, 50, 69) ~ "Pass", 
      scores >= 70            ~ "Outstanding!"
    )
  )

# case_when() replaces the for loop and the if statements

# Or we can do this in just one step:

tidyresults2 <- 
  tibble(scores = scores, 
         grades = case_when(
           scores < 50             ~ "Fail", 
           between(scores, 50, 69) ~ "Pass", 
           scores >= 70            ~ "Outstanding!"
         )
  )

# but I think it is better to do this in two steps because creating
# the tbl and then modifying it feel like two separate things

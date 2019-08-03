rm(list=ls())
# hsb2: High School and Beyond survey 
# File "hsb2.csv: A data frame with 200 observations and 11 variables.
# id: Student ID.
# female: Student's gender, with levels male (0) and female (1).
# race: Student's race, with levels: 
  # african american (=1)
  # asian (=2)
  # hispanic (=3) 
  # white (=4)
#ses: Socio economic status of student's family, with levels 
  # low (=1), middle (=2), and high (=3).
# schtyp: Type of school, with levels public (=1) and private (=2).
# prog: Type of program, with levels general (=1), academic (=2), and vocational (=3).
# read: Standardized reading score.
# write: Standardized writing score.
# math: Standardized math score.
# science: Standardized science score.
# socst: Standardized social studies score.

hsb2 <- read.csv("hsb2.csv")

m.factor <- lm(math ~ science*female, data = hsb2)
summary(m.factor)

# Prediction with a factor, when science = 71
science <- 71:74
dfp <- data.frame(science = rep(science, 4), 
                  female = rep( c(0,1), each = length(science))
                  )
dfp
cbind(dfp, yhat = predict(m.factor, newdata = dfp)) 

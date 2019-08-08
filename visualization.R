# R for Data Science
# https://r4ds.had.co.nz
# ggplot reference: https://ggplot2.tidyverse.org/reference/
library(tidyverse) # it includes ggplot2

# Dataset iris: regression line with confidence interval included
ggplot(iris, aes(x = Petal.Width, y = Sepal.Length)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")

# Dataset mtcars: ?mtcars for help
str(mpg)
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()

ggplot(mpg, aes(x=displ, y=hwy, color = class)) + geom_point()

ggplot(mpg, aes(x=displ, y=hwy, size = class)) + geom_point()

ggplot(mpg, aes(x=displ, y=hwy, alpha = class)) + geom_point()

ggplot(mpg, aes(x=displ, y=hwy, shape = class)) + geom_point()

ggplot(mpg, aes(x=displ, y=hwy)) + geom_point(color = "blue")

ggplot(mpg, aes(x=displ, y=hwy)) + geom_smooth(color = "blue")

# Jitter: adds random noise around each point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
# without jitter
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# coord_flip(): without flip
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

# coord_flip(): with flip
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()


# Facets: categorical variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)


# linetype
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, linetype = drv)) + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth()


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
# Duplication of code.
# We can pass the parameters one time, globally:

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# => different aesthetics in different layers
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = TRUE, level = .99)
# plus confidence interval around the line: se = TRUE (default = .95)
rm(list=ls())
library(ggplot2)
library(animation)
# Iris dataset: ?iris
str(iris) # 5 variables; Species is a factor

# There seems to be variation among different species
boxplot(iris$Sepal.Length ~ iris$Species)

# Visualize the boxplot
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_histogram()

# Classification: K-Means

set.seed(1) # to ensure reproducibility
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)
irisCluster

irisClusterAni <- kmeans.ani(iris[,3:4], 3)
table(irisClusterAni$cluster, iris$Species)/nrow(iris)

# cluster = k: number of clusters to use
# centers: matrix of cluster centers
# withinss: vector of within-cluster sum of squares: one component for each cluster
# tot.withinss = sum(withinss)
# size: number of points in each cluster
# totss = Total sum of squares
# betweenss = totss - totwithinss

table(irisCluster$cluster, iris$Species)
# setosa -> cluster 1
# versicolor -> cluster 3; two points misspecified in cluster 2
# virginica -> cluster 2, 4 points classified wrongly in cluster 3

irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
###################################################################

cleve <- 
  read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data",
           header=FALSE,sep=",",na.strings = '?')
cleve.names <- c("age", "sex", "cp", "trestbps", "chol",
                 "fbs", "restcg", "thalac", "exang", "oldpeak",
                 "slope", "ca", "thal", "diagnostic")
names(cleve) <- cleve.names
View(cleve)
# Documentation at 
# http://archive.ics.uci.edu/ml/datasets/Heart+Disease
str(cleve)

set.seed(1) # to ensure reproducibility
cleveCluster <- kmeans(cleve[, c("age", "diagnostic")], 5, nstart = 20)
table(cleveCluster$cluster, cleve$diagnostic)

cleve$diagnostic[cleve$diagnostic > 0] <- 1

cleveClusterAni <- kmeans.ani(cleve[,c("age","diagnostic")], 2)
table(cleveClusterAni$cluster, cleve$diagnostic)/nrow(cleve)
str(cleveClusterAni)

cleveClusterAni2 <- kmeans.ani(cleve[,c("age","trestbps", "diagnostic")], 2)
table(cleveClusterAni2$cluster, cleve$diagnostic)/nrow(cleve)

cleveCluster2 <- kmeans(cleve[, c("age", "diagnostic")], 2, nstart = 20)
table(cleveCluster2$cluster, cleve$diagnostic)

cleveCluster4 <- kmeans(cleve[, c("trestbps", "thalac", "diagnostic")], 2, nstart = 20)
options(digits = 2)
table(cleveCluster4$cluster, cleve$diagnostic)/nrow(cleve)

# There seems to be variation with increasing values of thalac
boxplot(cleve$thalac ~ cleve$diagnostic)

# Visualize the boxplot
ggplot(cleve, aes(thalac, age, color = as.factor(diagnostic))) + geom_point()

ggplot(cleve, aes(thalac, trestbps, color = as.factor(diagnostic))) + geom_point()

ggplot(cleve, aes(trestbps, age, color = as.factor(diagnostic))) + geom_point()

###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
###################################################################

subs401k <- read_csv("pCloud Sync/CADiR/subs401k.csv")

modelo.logit.subs <- glm(e401k ~ inc, 
                    data = subs401k, family = "binomial")
# summary(modelo.logit)
probs.predicted.subs <- predict(modelo.logit.subs, 
                           type = "response")
hist(subs401k$e401k)
options(digits = 3)
(m.subs  <- mean(subs401k$e401k))
summary(subs401k$e401k)
probs.predicted2.subs <- ifelse(probs.predicted.subs > m.subs, 1, 0)
table(subs401k$e401k, 
      probs.predicted2.subs)/nrow(subs401k)

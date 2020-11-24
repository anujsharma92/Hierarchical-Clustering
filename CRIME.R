# Load the dataset
library(readxl)
library(readr)
input <- read_csv(file.choose())
mydata <- input[ , c(2,3,4,5)]

summary(mydata)

# Normalize the data
normalized_data <- scale(mydata) # Excluding the university name

summary(normalized_data)

# Distance matrix
d <- dist(normalized_data, method = "euclidean") 

fit <- hclust(d, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k = 3) # Cut tree into 3 clusters

rect.hclust(fit, k = 3, border = "red")

membership <- as.matrix(groups)

final <- data.frame(membership, mydata)

aggregate(mydata[, 2:7], by = list(final$membership), FUN = mean)

library(readr)
write_csv(final, "hclustoutput.csv")

getwd()

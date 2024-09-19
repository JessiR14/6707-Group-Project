Script draft 
# Loading pollinator from a .txt file
Pollinators<- read.table(".txt", header = TRUE, sep = "\t")
# Count the number of columns
# Subset using base R
# Load the tidyverse package install.packages("tidyverse")
# Calculate the means
#Plots 
ggplot(cherrytree_data, aes(x = Girth, y = Height)) + geom_point(shape = 24, color = "orange", fill = NA, size = 3) + # Hollow orange triangles theme_bw() + labs(x = "Girth", y = "Height")
  
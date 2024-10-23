library(readr)
library(lme4)
library(ggplot2) 
library(tidyverse)
library(dplyr)
library(lmerTest)

pollinators <- read_csv("C:/Users/jessi/OneDrive/Documents/ENT Data Analysis/ENT6707/6707-Group-Project/Original_file_Breh/Pollinator_Obs_Data_24_ENT_6702.csv")

#Code for subsetting the data to hypothesis variables
post_data <- pollinators %>%
  filter(Application == "Post") %>%  
  droplevels() 

#Added variables are options, replace with actual variables we want
post_data<-subset(post_data, select=c("Application", "Treatment", "Pollination_event"))
str(post_data)

#Code for fitting to model
fit_pollinator <- lmer(Tree.height ~ DBH + (1|Region/Site/Plot), data=made_up_tree_data)
summary(fit_pollinator)

#Code for dealing with repeated measures (idk if we need this or not)
lmer_gaussian <- lmer(circumference~age + (1|Tree), data=Orange)
summary(lmer_gaussian)

#Graphing the data
new_data <- data.frame(age = seq(0, 1640, 0.01))
new_data$Predicted_lmer <- predict(lmer_gaussian,
                                   newdata=new_data, re.form=NA)
ggplot(data=Orange, mapping=aes(x=age, y=circumference, col=Tree))+
  geom_point()+theme_classic()+
  geom_line(data=new_data, aes(x=age, y=Predicted_lmer),
            color="dark blue", linewidth=1)

#Run anova with lmerTest package to get p-values (Dont use base R anova)
lmer_gaussian_fact <- lmer(circumference~factor(age)+ (1|Tree), data=Orange)
anova(lmer_gaussian_fact, type=3)
summary(lmer_gaussian_fact)


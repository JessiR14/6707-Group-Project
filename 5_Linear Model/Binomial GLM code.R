library(readr)
library(tidyverse)
library(car)

#Uploading/subsetting
Pollinator<- read_csv("1_Original_file_Breh/Pollinator_Obs_Data_24_ENT_6702.csv")
View(Pollinator)
str(Pollinator)

#Subset for post-application
subset_pollinator<-subset(Pollinator, Application=="Post")
summary(subset_pollinator)
str(subset_pollinator)

#Change treatment names to binomial integers
subset_pollinator$Treatment<-ifelse(subset_pollinator$Treatment=="Conventional",1,0)
subset_pollinator <- subset_pollinator %>%
  mutate(Treatment = as.integer(Treatment))

#Plot
plot(Treatment~jitter(Duration_of_visit,2), data=subset_pollinator, ylab="Treatment (IPPM/Conventional)", xlab="Duration of Visit")

#Fit Model 
fit <- glm(Treatment~Duration_of_visit,data=subset_pollinator,family=binomial(link=logit))
summary(fit)

#Assess fit 
plot(Treatment~jitter(Duration_of_visit,2), data=subset_pollinator, ylab="Treatment (IPPM/Conventional)", xlab="Duration of Visit")
new_data <- as.data.frame(seq(0,240,4)) 
colnames(new_data) <- "Duration_of_visit"
lines(new_data$Duration_of_visit,predict(fit,newdata=new_data,type="response"))

#Make Pretty
ggplot(subset_pollinator, aes(x=Duration_of_visit, y=Treatment))+
  geom_jitter(height=0)+
  xlab("Duration of Visit")+
  ylab("Treatment (IPPM/Conventional")+
  geom_smooth(method="glm", method.args=list(family="binomial"), se=FALSE)+
  geom_hline(data=data.frame(c(0.50)), aes(yintercept=c(0.50)), color="darkgray", linetype="dashed")

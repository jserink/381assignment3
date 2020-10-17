###### This is the file where you save your R code that produces the objects (graphs, tables) that you want to embed into 
# your assignment.  Make sure that there are no errors when you source this file before sourcing it from assignment3.Rmd file.
# To show you how it is done I have included code below that answers question 3.

rm(list=ls()) #makes sure that your work environment is clean.
library("tidyverse") #we use functions from this library.
slash <- ifelse(.Platform$OS.type=="unix", "/", "\\") #The eternal directory battle: Windows vs. *nix
####################which section?
section <- 1
#########################
mydf <- read_csv(paste("publicdata",section,slash,"wtpvswta",section,".csv",sep="")) # reads in the data
mydf$strategy <- factor(mydf$strategy,labels=c("no hints","hints")) # strategy is coded 0/1: instead give it meaningful names.
mydf$size <- factor(mydf$size,labels=c("group of 5","group of 20")) # size is coded 5/20: give it meaningful names.
mydf <- mydf%>%
  mutate(endowment_effect=ask-bid)

######Question 3

(first_plot <- mydf %>% # assign the name first_plot (referenced in your assignment3.Rmd file), use dataframe mydf THEN
  ggplot(aes(x=factor(size),y=bid,fill=strategy))+ # x axis is group size, y axis is bids, with separate boxes for strategies.
  geom_boxplot(outlier.shape = NA)+# do not plot outliers because we add data below.
  geom_point(position=position_jitterdodge(),alpha=0.3) + # the data with some random noise and transparency to avoid overplotting.
  labs(y="bids", x="subsequent group size",fill="strategy manipulation")) # some labels.



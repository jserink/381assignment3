# download data and create participation marks.
rm(list=ls())
library("tidyverse")
library("RMySQL")
source("credentials.R")
########################which section?
section <- 1
########################################
con <- dbConnect(RMySQL::MySQL(), host = hst, user = usr, password = pswd, dbname= db)
mydf <- dbGetQuery(con, paste("SELECT * FROM wtpvswta",section,sep=""))
write_csv(mydf, file=paste("publicdata",section,"/wtpvswta",section,".csv",sep=""))
participants <- mydf%>%group_by(oneid)%>%select(oneid)%>%summarize(`ex3 Points Grade`=2)
class <- read_csv("privatedata/class.csv")
class <-  class%>%mutate(OrgDefinedId=str_replace(OrgDefinedId,"#",""),
                         Username=str_replace(Username,"#",""),
                         oneid=as.numeric(str_sub(OrgDefinedId,-5)))
marks <- inner_join(class,participants)%>%
  select(OrgDefinedId,Username,`ex3 Points Grade`,`End-of-Line Indicator`)%>%
  replace_na(list(OrgDefinedId=0,Username=0,ex1=0,`End-of-Line Indicator`=0))
write_csv(marks,paste("privatedata/marks",section,".csv",sep=""))


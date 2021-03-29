################################################################################################################################### load libraries


library(gdata)
library(ggplot2)                                # libraries needed to run the script



################################################################################################################################### functions

df <- function(x,y) sqrt(((x)^2)+((y)^2))      # Distance between set of coordinates function
std <- function(x) sd(x)/sqrt(length(x))       # Standard error function


##################################################################################################################################### Information about Experiment and Group
Experiment <-"Standard"                       # name of Experiment
Group<-"ForS"                                # name of Group
Group_name <- paste(Experiment,Group)        # name of Experiment and Group
                                            
setwd("C:/Users/.../Trajectories")      # set working directory of text files


#################################################################################################################################### Run for loop
Exp_Group <- paste(Experiment,"/",Group,sep="")
file_<-list.files(Exp_Group,full.names=T)                 # list files
file_

l <- length(file_)                                       # number of files in folder
l



data <-data.frame()
for (z in 1:l) {
  
  
    nr <- file_[z]
    nr
  
  
    
    file <-read.table(nr, header = FALSE, sep = "", dec = ",")
    file
    file_cut <- subset(file, V1 <= 60000)         # shorten data to 60 s
    file_cut

    x <- file_cut$V2                             # x- coordinates
    y <-file_cut$V3                              # y - coordinates
  
    #################################################################################  Calculate Distance
    xdif <- ave(x, FUN = function(x) c(0, diff(x)))  # x(t)-x(t+1) 
    ydif <- ave(y, FUN = function(x) c(0, diff(x)))  # y(t)-y(t+1)
  
    dist <-df(xdif,ydif)                            # distances between single pairs of coordinates
    dist
    
    cm_distance<-sum(dist)                         # total distance in cm
    cm_distance
  
   
    plot(x,y, type="l",main = sub('\\..*$', '', basename(nr)),xlim = c(-3,3),ylim = c(-6,6))            # plot trajectory (x and y coordinates)
    mtext(paste("Distance=",round(cm_distance,digits = 3),"cm"),side=3)                                # information about file name and calculated distance
  
   ################################################################################### Time of first movement
  
    zero <-dist[dist!=0][1]                # first distance not zero                                  
    zero
    nr <- which(dist==zero)[1]            # number of this first distance
    nr_time <- nr +1                      #number of time after first distance is not zero
    nr_time
  
    time_firstmoving <-file_cut$V1[nr_time]   # time after first distance is not zero
    time_firstmoving
  
  ####################################################################################
  
  
    data1 <-data.frame(Experiment,Group,cm_distance,time_firstmoving)  # data frame with name of Experiment, name of Group, Total Distance and Time of first movement
    data = rbind(data,data1)                                                     # rbind data
    
    

  
   z+1
}

data
########################################################################################################################################### Barplot of mean distance
data                      # data frame with name of Experiment, name of Group, Total Distance and Time of first movement
d1 <- data$cm_distance    # all distances
d1
mean_dist <-mean(d1)     # mean distance
mean_dist
std_dist <-std(d1)       # standard error
std_dist
len_dist <- length(d1)  # sample size
len_dist




mid_dist <- barplot(mean_dist,ylab="Distance in cm/min",ylim=c(0,10),xlim=c(0,5),names.arg = Group_name)
barplot(mean_dist,ylab="Distance in cm/min",ylim=c(0,10),xlim=c(0,5),names.arg = Group_name)    #plot barplot of mean distance 
arrows(x0=mid_dist, y0=mean_dist-std_dist, x1=mid_dist, y1=mean_dist+std_dist, code=3, angle=90, length=0.1)    #error bar 
text(mid_dist, 0, paste("n = ", len_dist),cex=0,75,pos=3)    # sample size

###################################################################################################################################### Barplot of mean time of first movement
data
d2 <- data$time_firstmoving  #times of first movement
mean_time <-mean(d2)
mean_time
std_time <-std(d2)
std_time
len_time <- length(d2)
len_time




mid_time<- barplot(mean_time,ylab="Time of first movement in ms",ylim=c(0,10000),xlim=c(0,5),names.arg = Group_name)
barplot(mean_time,ylab="Time of first movement in ms",ylim=c(0,10000),xlim=c(0,5),names.arg = Group_name)    #plot barplot of mean time of first movement

arrows(x0=mid_time, y0=mean_time-std_time, x1=mid_time, y1=mean_time+std_time, code=3, angle=90, length=0.1)    



text(mid_time, 0, paste("n = ", len_time),cex=0,75,pos=3)   


##################################################################################################################################### Safe data in csv file


data
name_csv <-paste(Experiment,"_",Group,".csv",sep="")   # name of file
name_csv

setwd("C:/Users/.../Distances")    # set working directory for saving the file

write.csv(data,file = name_csv)     # write file


##################################################################################################################################



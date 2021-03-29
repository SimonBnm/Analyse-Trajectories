################################################################################################################################## libraries

library("ggplot2")
library("readxl")                              #libraries needed to run the script
library("gdata")
library("ggsignif")
################################################################################################################################# functions



std <- function(x) sd(x)/sqrt(length(x))        # standard error function

makeStars <- function(x){                        # significance stars function
  stars <- c("****", "***", "**", "*", "ns")
  vec <- c(0, 0.0001, 0.001, 0.01, 0.05, 1)
  i <- findInterval(x, vec)
  stars[i]
}

##################################################################################################################################  set wd



setwd("C:/Users/.../Distances")   # set working directory of distance csv files

##################################################################################################################################

file_ <- list.files(full.names=T)
file_
file_nr <- length(file_)
file_nr


Distance <-setNames(data.frame(matrix(ncol = 5, nrow = 0)), c("Experiment","Group", "mean", "st_err","len"))
Time <-setNames(data.frame(matrix(ncol = 5, nrow = 0)), c("Experiment","Group", "mean", "st_err","len"))


for (z in 1:file_nr) {
  
  nr <- file_[z]
  nr
  
  groupx <-list.files(nr,full.names=T)
  groupx
  
  l_groupx <- length(groupx)
  l_groupx
  
  for (i in 1:l_groupx) {
    groupx
    gx <- groupx[i]
    gx


    g<-read.csv(gx)
    g
    
  
    dist <- g$cm_distance
    time <- g$time_firstmoving
    

    mean_dist <- mean(dist)
    mean_time <- mean(time)
  

    st_err_dist <-std(dist)
    st_err_time <-std(time)
 
  
    len_dist <- length(dist)
    len_time <- length(time)
    
  
  
    
    Experiment<-g$Experiment[1]
    Experiment
    Group <- g$Group[1]
    Group
  
    data1 <-data.frame(Experiment,Group,mean_dist,st_err_dist,len_dist)
    data2 <- data.frame (Experiment,Group,mean_time,st_err_time,len_time)
    
  
    Distance = rbind(Distance,data1)
    Time = rbind(Time,data2)
    
  
  i+1
  }
  
  
  z+1
  
}

Distance  
Time







###################################################################################################################### Calculate p values between groups
p_values <-data.frame(matrix(ncol = 1, nrow = 0))

for (z in 1:file_nr) {
  nr <- file_[z]
  nr
  
  groupx <-list.files(nr,full.names=T)
  groupx
  
  l_groupx <- length(groupx)
  l_groupx
  
  
  mid_group <-data.frame(matrix(ncol = 1, nrow = 0))
  
  for (i in 1:l_groupx) {
    
    
    gr <- groupx[i]
    gr
    
    g<-read.csv(gr)
    g
    
    exp <- g$Experiment[1]
    exp
    group <- g$Group[1]
    group
    name  <- paste(exp,"_",group,sep="")
    name
    
    
    mid_dist <-as.data.frame(g$cm_distance)  
    mid_dist
    colnames(mid_dist) <- name
    mid_dist
    
    mid_group = cbindX(mid_group,mid_dist)
    mid_group
    
    
    i+1
    
    
    
  }
  
  
  mid_group
  m_group <- mid_group[-1]
  m_group
  
  ForR <-m_group[,1]
  ForR
  ForS <- m_group[,2]
  ForS
  
  t_test <-t.test(ForR,ForS)
  t_test
  
  p_val <-as.data.frame(t_test$p.value)
  p_val
  colnames(p_val) <- exp
  p_values = cbindX (p_values,p_val)
  p_values
  
  
  
  
  
  
  z+1
  
}

p_values
p_vals <-p_values[-1]
p_vals

p <- as.numeric(p_vals)
p




makeStars <- function(x){
  stars <- c("****", "***", "**", "*", "ns")
  vec <- c(0, 0.0001, 0.001, 0.01, 0.05, 1)
  i <- findInterval(x, vec)
  stars[i]
}

stars <- makeStars(p)     # p values in stars
stars
############################################################################################################################################ Barplot mean Distances

Distance$Experiment<-factor(Distance$Experiment, levels = unique(Distance$Experiment), ordered=TRUE)
Distance


number_groups <-(length(Distance$Experiment)/2)-1
number_groups



p_xmin <- data.frame()
p_ymin <- data.frame()

for (i in 0:number_groups){
  
  x <-as.data.frame(0.75 + i)
  y <-as.data.frame(1.25 + i)
  p_xmin=rbind(p_xmin,x)
  p_ymin=rbind(p_ymin,y)
  
  
  i+1
  
  
}

p_xmin
p_ymin

x_min <-p_xmin$`0.75 + i`
y_min <- p_ymin$`1.25 + i`
x_min
y_min


p <-ggplot(Distance,aes(Experiment,mean_dist,fill=Group,ymax = max(mean_dist))) + geom_bar(stat = "identity",position = "dodge")+scale_fill_brewer(palette = "Set1")+labs(x="", y="Distance moved after 60s (cm)")
pp <- p+geom_errorbar(aes(ymin = mean_dist-st_err_dist,ymax=mean_dist+st_err_dist),width=.2,position=position_dodge(.9))
ppp <-pp+geom_text(aes(label=len_dist),y=0.12, position=position_dodge(width=0.9), size=4)
ppp

pppp <- ppp + geom_signif(y_position = 6.8,xmin = x_min,xmax = y_min,annotation=stars,textsize=5)
pppp







################################################################################################################ Barplot mean time of first movement




Time


Time$Experiment<-factor(Time$Experiment, levels = unique(Time$Experiment), ordered=TRUE)
Time


p <-ggplot(Time,aes(Experiment,mean_time,fill=Group,ymax = max(mean_time))) + geom_bar(stat = "identity",position = "dodge")+scale_fill_brewer(palette = "Set1")+labs(x="", y="Time of first movement (ms)")
p
pp <- p+geom_errorbar(aes(ymin = mean_time-st_err_time,ymax=mean_time+st_err_time),width=.2,position=position_dodge(.9))

pp
ppp <-pp+geom_text(aes(label=len_dist),y=0.12, position=position_dodge(width=0.9), size=4)




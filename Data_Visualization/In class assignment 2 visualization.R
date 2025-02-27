#Load the data
mycotoxin<-read.csv("C:/Users/paude/OneDrive/Documents/RT-qPCR-data-analysis/MycotoxinData.csv",na.strings="na")

####Make a boxplot using ggplot with DON as the y variable, treatment as the x variable, and color mapped to the wheat cultivar. Show the code you use to load the libraries you need to read in the data and make the plot. Change the y label to “DON (ppm)” and make the x label blank.
library(ggplot2)
ggplot(mycotoxin,aes(x=Treatment,y=DON,color= Cultivar))+     #defined asthetics
  geom_boxplot()+      #added a box plot
xlab("")+      #xlabel
ylab("DON(ppm)")    #add y label


#### Now convert this data into a bar chart with standard-error error bars using the stat_summary() command.
ggplot(mycotoxin,aes(x=Treatment,y=DON,color= Cultivar))+
stat_summary(fun=mean,geom="bar",position="dodge")+      # fun=mean, represents the bar as mean of  DON value and dodging 
  stat_summary(fun.data=mean_se, geom="errorbar", position="dodge")+      # adding error bars using SE
  xlab("")+
  ylab("DON(ppm)")
  
####Add points to the foreground of the boxplot and bar chart you made in question 3 that show the distribution of points over the boxplots. Set the shape = 21 and the outline color black (hint: use jitter_dodge). 
###boxplot with colour black and fill with ciltivar. 
ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
    geom_boxplot()+
    xlab("")+
    ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black")   #adding points and jitter dodging

### barchart with colour black and fill with ciltivar
ggplot(mycotoxin,aes(x=Treatment,y=DON,color= Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se, geom="errorbar", position="dodge")+
xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black")   #jitter points to avoid overlap with the corresponding plots


####Change the fill color of the points and boxplots to match some colors in the following colorblind pallet. cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
cbbPalette <- c( "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
  geom_boxplot()+
  xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black")+
  scale_fill_manual(values=cbbPalette)   #changed the fill colour of points and box plots to cbbpalette   

ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se, geom="errorbar", position="dodge")+
  xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black")+
  scale_fill_manual(values=cbbPalette)


####Add a facet to the plots based on cultivar.
ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
  geom_boxplot()+
  xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black")+
  scale_fill_manual(values=cbbPalette)+
  facet_wrap(~Cultivar,scales="free")      #added a facet


ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se, geom="errorbar", position="dodge")+
  xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black")+
  scale_fill_manual(values=cbbPalette)+       #Manually sets fill colors for different cultivars using the cbbPalette
  facet_wrap(~Cultivar,scales="free")

####Add transparency to the points so you can still see the boxplot or bar in the background. 
ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
  geom_boxplot()+
  xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black",alpha=0.4)+     #alpha gives the transparency
  scale_fill_manual(values=cbbPalette)+
  facet_wrap(~Cultivar,scales="free")


ggplot(mycotoxin,aes(x=Treatment,y=DON,fill= Cultivar))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se, geom="errorbar", position="dodge")+
  xlab("")+
  ylab("DON(ppm)")+
  geom_point(position=position_jitterdodge(dodge.width=0.9),shape=21,colour="black",alpha=0.4)+
  scale_fill_manual(values=cbbPalette)+
  facet_wrap(~Cultivar,scales="free")


####Explore one other way to represent the same data https://ggplot2.tidyverse.org/reference/ . Plot them and show the code here. Which one would you choose to represent your data and why? 
#### I chose to go with the geom_violin.
ggplot(mycotoxin, aes(Treatment, DON, fill = Cultivar)) +
geom_violin(scale = "width",alpha=0.4,trim = FALSE, adjust=0.5, colour="blue") +   #scale width maximize the width of all violin to 1,adjust gave the smaller bandwidth. 
geom_boxplot(width = 0.20,   #width of boxplot
             position = position_dodge(0.9),color = "black") +  
xlab("") +
ylab("DON (ppm)") +
theme(legend.position = "right")+   #make the legend to appear in the right side of the plot.
geom_point(position = position_jitterdodge(dodge.width = 0.9),shape = 21,color = "black",alpha = 0.4)



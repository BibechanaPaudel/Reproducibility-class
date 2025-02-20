####Load the data
mycotoxin<-read.csv("MycotoxinData.csv", na.string="na")
####Load library
library(ggplot2)
####Load cbbPalette
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
####Using ggplot, create a boxplot of DON by Treatment so that the plot looks like the image below.
#a.	Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete introduced last week. 
#b.	Change the transparency of the jittered points to 0.6. 
#c.	The y-axis should be labeled "DON (ppm)", and the x-axis should be left blank. 
#d.	The plot should use a classic theme
#e.	The plot should also be faceted by Cultivar

mycotoxin.DON<-ggplot(mycotoxin,aes(Treatment,DON, fill=Cultivar))+
  geom_boxplot(outlier.shape=NA)+   # Add boxplots and remove the outlier shape that are missing. 
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+    ## Add jittered points to show individual data points, avoiding overlap and increase the transparency
  xlab("")+   #label the x-axis
  ylab("DON(ppm")+    #label the y-axis
  scale_fill_manual(values=cbbPalette[c(3,4)])+    #fill the plot with colourblind friendly palette
  theme_classic()+    
  facet_wrap(~Cultivar, scales="free")   #facet wrap by cultivar
mycotoxin.DON


####Change the factor order level so that the treatment “NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70. 
mycotoxin$Treatment_ordered=factor(mycotoxin$Treatment, levels=c("NTC","Fg","Fg + 37","Fg + 40","Fg + 70"))

plot2<-ggplot(mycotoxin,aes(Treatment_ordered,DON, fill=Cultivar))+    #defined asthetic, here we used the treatment_ordered at x-axis in which the levels were arranged as we prefer
  geom_boxplot(outlier.shape=NA)+
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+
  xlab("")+
  ylab("DON(ppm")+
  scale_fill_manual(values=cbbPalette[c(3,4)])+
  theme_classic()+
  facet_wrap(~Cultivar, scales="free")
plot2


####Change the y-variable to plot X15ADON and MassperSeed_mg. The y-axis label should now be “15ADON” and “Seed Mass (mg)”. Save plots made in questions 1 and 3 into three separate R objects.
mycotoxin.X15ADON<-ggplot(mycotoxin,aes(Treatment,X15ADON, fill=Cultivar))+    #define asthetics x-axis as Treatment and y-axis as X15ADON
  geom_boxplot(outlier.shape=NA)+
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+
  xlab("")+
  ylab("15ADON")+   #label y-axis as 15ADON
  scale_fill_manual(values=cbbPalette[c(3,4)])+
  theme_classic()+
  facet_wrap(~Cultivar, scales="free")
mycotoxin.X15ADON

mycotoxin.seed<-ggplot(mycotoxin,aes(Treatment,MassperSeed_mg, fill=Cultivar))+    #define asthetics x-axis as Treatment and y-axis as MassperSeed_mg
  geom_boxplot(outlier.shape=NA)+
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+
  xlab("")+
  ylab("Seed Mass (mg)")+ #label y axis as Seed Mass (mg)
  scale_fill_manual(values=cbbPalette[c(3,4)])+
  theme_classic()+
  facet_wrap(~Cultivar, scales="free")
mycotoxin.seed



####Use ggarrange function to combine all three figures into one with three columns and one row. Set the labels for the subplots as A, B and C. Set the option common.legend = T within ggarage function. What did the common.legend option do?
#a.	HINT: I didn’t specifically cover this in the tutorial, but you can go to the help page for the ggarange function to figure out what the common.legend option does and how to control it. 
library(ggpubr)  #Load the library to use ggarrange function.
fig1 <- ggarrange(
          mycotoxin.DON,  # First plot
          mycotoxin.X15ADON,  # Second plot
          mycotoxin.seed,  # Third plot
          labels = c("A","B","C"),  # label the plots A, B and C
          nrow = 1,  # Arrange the plots in 3 rows
          ncol = 3,  # Arrange the plots in 1 column
          common.legend = T #include a legend in the combined figure
        )
fig1
help(ggarrange)
# The common.legend option added a common legend for the arranged boxplots that is representative for all the plots.
        
        
####Use geom_pwc() to add t.test pairwise comparisons to the three plots made above. Save each plot as a new R object, and combine them again with ggarange as you did in question 4. 
mycotoxin.DON.significance<-mycotoxin.DON+
geom_pwc(aes(group=Treatment), method="t.test", label = "{p.adj.format}{p.adj.signif}", hide.ns=T)    #do the pairwise t.test,display the significance by p value and *
mycotoxin.DON.significance
        
mycotoxin.X15ADON.significance<-mycotoxin.X15ADON+
geom_pwc(aes(group=Treatment), method="t.test", label = "{p.adj.format}{p.adj.signif}", hide.ns=T)
mycotoxin.X15ADON.significance 

mycotoxin.seed.significance<-mycotoxin.seed+
geom_pwc(aes(group=Treatment), method="t.test", label = "{p.adj.format}{p.adj.signif}", hide.ns=T)
mycotoxin.seed.significance 
 #Combining all the figures into one.        
fig2 <- ggarrange(
          mycotoxin.DON.significance,  # First plot
          mycotoxin.X15ADON.significance,  # Second plot
          mycotoxin.seed.significance,  # Third plot
          labels = c("A","B","C"),  # label the plots A, B and C
          nrow = 1,  # Arrange the plots in 3 rows
          ncol = 3,  # Arrange the plots in 1 column
          common.legend = T #include a legend in the combined figure
        )
        fig2
        
        
### Data Visualization 2
####Load the packages
library(tidyverse)
install.packages("ggpubr")
library(ggpubr)
install.packages("ggrepel")
library(ggrepel)
library(ggplot2)
install.packages("ggarrange")
library(ggarrange)


###Load the cbbPalette. This color pallete is used consistently in each figure and each variable is the same color across each figure. 
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

####Load the file
sample.data.bac<-read.csv("C:/Users/paude/OneDrive/Documents/RT-qPCR-data-analysis/BacterialAlpha.csv", na.strings="na")
#Make the variables as factor
sample.data.bac$Time_Point<-as.factor(sample.data.bac$Time_Point)
sample.data.bac$Crop<-as.factor(sample.data.bac$Crop)
#Change the levels as we prefer.
sample.data.bac$Crop=factor(sample.data.bac$Crop, levels=c("Soil","Cotton","Soybean"))


####Make the boxplot, bacterial evenness
#Plot one-B

bac.even<-ggplot(sample.data.bac, aes(x=Time_Point, y=even, color=Crop))+  # Define aesthetics: x-axis as Time.Point, y-axis as even, and color by Crop
  geom_boxplot(position=position_dodge())+      # Add boxplots with dodged positions to avoid overlap
  geom_point(position=position_jitterdodge(0.05))+     # Add jittered points to show individual data points, avoiding overlap
  xlab("Time")+   # Label the x-axis
  ylab("Pielou's evenness")+    # Label the y-axis
  scale_colour_manual(values=cbbPalette)+
  theme_classic()    # Use a classic theme for the plot
bac.even


####### Water Imbibition correlate with bacterial evenness; Figure 2A #####
sample.data.bac.no.soil<-subset(sample.data.bac, Crop!="Soil")
water.imbibed <- ggplot(sample.data.bac.no.soil, aes(Time_Point, 1000 * Water_Imbibed, color = Crop)) +  # Define aesthetics: x-axis as Time.Point, y-axis as Water_Imbibed (converted to mg), and color by Crop
  geom_jitter(width = 0.5, alpha = 0.5) +  # Add jittered points to show individual data points with some transparency
  stat_summary(fun = mean, geom = "line", aes(group = Crop)) +  # Add lines representing the mean value for each Crop group
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +  # Add error bars representing the standard error of the mean
  xlab("Hours post sowing") +  # Label the x-axis
  ylab("Water Imbibed (mg)") +  # Label the y-axis
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[3]]), name = "", labels = c("", "")) +  # Manually set colors for the Crop variable
  theme_classic() +  # Use a classic theme for the plot
  theme(strip.background = element_blank(), legend.position = "none") +  # Customize theme: remove strip background and position legend to the right
  facet_wrap(~Crop, scales = "free")  # Create separate panels for each Crop, allowing free scales
water.imbibed


####Figure 2c #####
water.imbibed.cor <- ggplot(sample.data.bac.no.soil, aes(y = even, x = 1000 * Water_Imbibed, color = Crop)) +  # Define aesthetics: y-axis as even, x-axis as Water_Imbibed (converted to mg), and color by Crop
  geom_point(aes(shape = Time_Point)) +  # Add points with different shapes based on Time.Point
  geom_smooth(se = FALSE, method = lm) +  # Add a linear model smooth line without confidence interval shading
  xlab("Water Imbibed (mg)") +  # Label the x-axis
  ylab("Pielou's evenness") +  # Label the y-axis
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[3]]), name = "", labels = c("Cotton", "Soybean")) +  # Manually set colors for the Crop variable
  scale_shape_manual(values = c(15, 16, 17, 18), name = "", labels = c("0 hrs", "6 hrs", "12 hrs", "18 hrs")) +  # Manually set shapes for the Time.Point variable
  guides(color="none")+  #Remove the color legend
  theme_classic() +  # Use a classic theme for the plot
  theme(strip.background = element_blank(), legend.position = "right") +
  facet_wrap(~Crop, scales = "free")  # Create separate panels for each Crop, allowing free scales

water.imbibed.cor



######## Figure 2; significance levels added with Adobe or powerpoint #### 

# Arrange multiple ggplot objects into a single figure
figure2 <- ggarrange(
  water.imbibed,  # First plot: water.imbibed
  bac.even,  # Second plot: bac.even
  water.imbibed.cor,  # Third plot: water.imbibed.cor
  labels = "auto",  # Automatically label the plots (A, B, C, etc.)
  nrow = 3,  # Arrange the plots in 3 rows
  ncol = 1,  # Arrange the plots in 1 column
  legend = FALSE  # Do not include a legend in the combined figure
)
figure2


####Integrate the basic statistics within the plots for exploratory analyses####
bac.even+
  stat_compare_means(method="anova")  #apply anova to the groups
### Example with pvalues as significance levels
bac.even+
  geom_pwc(aes(group=Crop), method="t.test", label="p.adj.format")

bac.even+
  geom_pwc(aes(group=Time_Point), method="t.test", label="p.adj.format")

### example with * as significance levels
bac.even + 
  geom_pwc(aes(group = Crop), method = "t.test", label = "{p.adj.format}{p.adj.signif}")


###Display the correlation data
water.imbibed.cor + 
  stat_cor()

###Display the regression line
water.imbibed.cor + 
  stat_regline_equation()

####Specific point labelling for emphasizing some points
#Load the data
diff.abund<-read.csv("C:/Users/paude/OneDrive/Documents/RT-qPCR-data-analysis/diff_abund.csv")
str(diff.abund)     #structure of the data

diff.abund$log10_pvalue<- -log10(diff.abund$p_CropSoybean)   #transform the pvalue of soybean to -log10
diff.abund.label<-diff.abund[diff.abund$log10_pvalue>30,]       #subset values with log10_p value greater than 30

ggplot()+
  geom_point(data=diff.abund,aes(x=lfc_CropSoybean,y=log10_pvalue,color=diff_CropSoybean))+       #add the required asthetics to the plot
  geom_point(data=diff.abund.label,aes(x=lfc_CropSoybean,y=log10_pvalue,color=diff_CropSoybean), shape=17, color="red", size=4)+        #emphasize the desired points with different colour and shape
  theme_classic()+
  geom_text_repel(data=diff.abund.label,aes(x=lfc_CropSoybean,y=log10_pvalue,color=diff_CropSoybean,label=Label), color="red")+   #add text to the points we want to emphasize
  scale_color_manual(values=cbbPalette,name="Significant")+     #Use the colourblind friendly palette
  xlab("Log fold change soil vs. soybean")+
  ylab(" -log10 p value")








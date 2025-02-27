## Link to the manuscript

[Plant Disease](https://doi.org/10.1094/PDIS-06-21-1253-RE)

# Take the code you wrote for coding challenge 3, question 5, and incorporate it into your R markdown file. Some of you have already been doing this, which is great! Your final R markdown file should have the following elements.

## At the top of the document, make a clickable link to the manuscript where these data are published. The link is here:

- Noel, Z.A., Roze, L.V., Breunig, M., Trail, F. 2022. Endophytic fungi
  as promising biocontrol agent to protect wheat from Fusarium
  graminearum head blight. Plant Disease.
  <https://doi.org/10.1094/PDIS-06-21-1253-RE>

## Read the data using a relative file path with na.strings option set to “na”. This means you need to put the Mycotoxin.csv file we have used for the past two weeks into your directory, which git tracks.

``` r
####Load the data
mycotoxin<-read.csv("Data_Visualization/MycotoxinData.csv", na.string="na")
####Load library
library(ggplot2)
library(ggpubr)
####Load cbbPalette
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
```

## Make a separate code chunk for the figures plotting the DON data, 15ADON, and Seedmass, and one for the three combined using ggarrange.

``` r
####Using ggplot, create a boxplot of DON by Treatment so that the plot looks like the image below.
#a. Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete introduced last week. 
#b. Change the transparency of the jittered points to 0.6. 
#c. The y-axis should be labeled "DON (ppm)", and the x-axis should be left blank. 
#d. The plot should use a classic theme
#e. The plot should also be faceted by Cultivar

mycotoxin.DON<-ggplot(mycotoxin,aes(Treatment,DON, fill=Cultivar))+
  geom_boxplot(outlier.shape=NA)+   # Add boxplots and remove the outlier shape that are missing. 
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+    ## Add jittered points to show individual data points, avoiding overlap and increase the transparency
  xlab("")+   #label the x-axis
  ylab("DON(ppm")+    #label the y-axis
  scale_fill_manual(values=cbbPalette[c(3,4)])+    #fill the plot with colourblind friendly palette
  theme_classic()+    
  facet_wrap(~Cultivar, scales="free")   #facet wrap by cultivar
mycotoxin.DON
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
####Change the y-variable to plot X15ADON and MassperSeed_mg. The y-axis label should now be “15ADON” and “Seed Mass (mg)”. Save plots made in questions 1 and 3 into three separate R objects.
mycotoxin.X15ADON<-ggplot(mycotoxin,aes(Treatment,X15ADON, fill=Cultivar))+    #define asthetics x-axis as Treatment and y-axis as X15ADON
  geom_boxplot(outlier.shape=NA)+
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+
  xlab("")+
  ylab("15ADON")+   #label y-axis as 15ADON
  scale_fill_manual(values=cbbPalette[c(3,4)])+
  theme_classic()+
  facet_wrap(~Cultivar, scales="free")
```

``` r
mycotoxin.X15ADON
```

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
mycotoxin.seed<-ggplot(mycotoxin,aes(Treatment,MassperSeed_mg, fill=Cultivar))+    #define asthetics x-axis as Treatment and y-axis as MassperSeed_mg
  geom_boxplot(outlier.shape=NA)+
  geom_point(position=position_jitterdodge(0.05), shape=21, alpha=0.6)+
  xlab("")+
  ylab("Seed Mass (mg)")+ #label y axis as Seed Mass (mg)
  scale_fill_manual(values=cbbPalette[c(3,4)])+
  theme_classic()+
  facet_wrap(~Cultivar, scales="free")
mycotoxin.seed
```

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->

``` r
####Use geom_pwc() to add t.test pairwise comparisons to the three plots made above. Save each plot as a new R object, and combine them again with ggarange as you did in question 4. 
mycotoxin.DON.significance<-mycotoxin.DON+
geom_pwc(aes(group=Treatment), method="t.test", label = "{p.adj.format}{p.adj.signif}", hide.ns=T)    #do the pairwise t.test,display the significance by p value and *
mycotoxin.DON.significance
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
mycotoxin.X15ADON.significance<-mycotoxin.X15ADON+
geom_pwc(aes(group=Treatment), method="t.test", label = "{p.adj.format}{p.adj.signif}", hide.ns=T)
mycotoxin.X15ADON.significance 
```

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
mycotoxin.seed.significance<-mycotoxin.seed+
geom_pwc(aes(group=Treatment), method="t.test", label = "{p.adj.format}{p.adj.signif}", hide.ns=T)
mycotoxin.seed.significance 
```

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-5-3.png)<!-- -->

``` r
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
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

``` r
        fig2
```

![](R_markdown_class_assignment_files/figure-gfm/unnamed-chunk-5-4.png)<!-- -->

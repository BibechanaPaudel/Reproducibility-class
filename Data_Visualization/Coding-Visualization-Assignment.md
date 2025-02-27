\`

``` r
#
data("mtcars") #in build dataset in R.
str(mtcars) #structure of data
```

    ## 'data.frame':    32 obs. of  11 variables:
    ##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
    ##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
    ##  $ disp: num  160 160 108 258 360 ...
    ##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
    ##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
    ##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
    ##  $ qsec: num  16.5 17 18.6 19.4 17 ...
    ##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
    ##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
    ##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
    ##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

``` r
####scatter plot using Base R. 
plot(mtcars$wt,mtcars$mpg)
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
#### Can make it more fancier by adding on more details
plot(mtcars$wt,mtcars$mpg,
     xlab="Car Weight",   #add x label
     ylab="Miles per gallon",   #add y label
     font.lab=6,   #font of the labels
     pch=23) #printing character
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

``` r
####ggplot2####
library(ggplot2)  #load the library
ggplot(mtcars,   #provide the data frame to be used
       aes(x=wt,y=mpg)) + geom_point()+     #No need to add the dollar sign with aes, "+" sign is used to add on other data structure in the ggplot
  geom_smooth(method=lm,se=FALSE)    #geom_smooth adds a smooth line, method=lm shows the linear relationship, without the confidence interval
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
####Note: If we change the order of geom_smooth and geom_point, then the line will move backward. 
ggplot(mtcars,   
       aes(x=wt,y=mpg)) +      
  geom_smooth(method=lm,se=FALSE) +
  geom_point()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->

``` r
#### Add the aesthetic 
#if we add size in the asthetic it tries to apply the function to all the layers so if we want to add the size to any single layer just add it on that layer . 
#If we want to change the color as per the size we have to include that in the aes. 
ggplot(mtcars,   
       aes(x=wt,y=mpg)) +      
  geom_smooth(method=lm,se=FALSE, color="purple") + #change the colour of the line
  geom_point(aes(size=wt),colour="red")+
  xlab("Weight")+
  ylab("Miles per gallon")
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-2-3.png)<!-- -->

``` r
ggplot(mtcars,aes(x=wt,y=mpg)) +      
  geom_smooth(method=lm,se=FALSE, color="purple") + #change the colour of the line
  geom_point(aes(size=wt,colour=wt))+
  xlab("Weight")+
  ylab("Miles per gallon")
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-2-4.png)<!-- -->

``` r
# if we want to make by different variable and colour by different variable. 

ggplot(mtcars,aes(x=wt,y=mpg)) +      
  geom_smooth(method=lm,se=FALSE, color="purple") + #change the colour of the line
  geom_point(aes(size=cyl,colour=hp))+
  xlab("Weight")+
  ylab("Miles per gallon")+
#if we want to change the gradient of the colour
  scale_color_gradient(low="yellow", high="green")+
#if we want to change the x axis scale into log10
  scale_x_log10()+
  #to add continuous scale to y axis  
  scale_y_continuous(labels=scales::percent)
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-2-5.png)<!-- -->

``` r
#Load the data
bull.richness<-read.csv("C:/Users/paude/OneDrive - Auburn University/Reproducibility/Reproducibility_Code_Assignment/Bull_richness.csv")     
bull.richness.soy.no.till<-bull.richness[bull.richness$Crop=="Soy" & bull.richness$Treatment=="No-till",] #subset to soy data



####ggplot, it colors accrording to the fungicide, boxplot
ggplot(bull.richness.soy.no.till,aes(x=GrowthStage,y=richness,color=Fungicide))+
  geom_boxplot()+
  xlab("")+
  ylab("Fungal Richness")+
 #position jitter dodge keeps the point away from each other
  #geom_point(position=position_dodge(width=0.9))   #width determines the distance from the boxplot
  geom_point(position=position_jitterdodge(dodge.width=0.9))
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
####Bar charts
#stats_summary
ggplot(bull.richness.soy.no.till,aes(x=GrowthStage,y=richness,color=Fungicide))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se,geom="errorbar", position="dodge")+
  xlab("")+
  ylab("Fungal Richness")+
 #position jitter dodge keeps the point away from each other
  #geom_point(position=position_dodge(width=0.9))   #width determines the distance from the boxplot
  geom_point(position=position_jitterdodge(dodge.width=0.9))
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
#use the fill option to fill the barplot to the different colour inplace of only the outline.
ggplot(bull.richness.soy.no.till,aes(x=GrowthStage,y=richness,fill=Fungicide))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se,geom="errorbar", position="dodge")+
  xlab("")+
  ylab("Fungal Richness")+
 #position jitter dodge keeps the point away from each other
  #geom_point(position=position_dodge(width=0.9))   #width determines the distance from the boxplot
  geom_point(position=position_jitterdodge(dodge.width=0.9))
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-4-2.png)<!-- -->

``` r
# If we use both the colour and fill option , the error bars also changes into the same colour as the bar. 
ggplot(bull.richness.soy.no.till,aes(x=GrowthStage,y=richness,color=Fungicide, fill=Fungicide))+
  geom_point(position=position_jitterdodge(dodge.width=0.9))+
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_se,geom="errorbar", position="dodge")+
  xlab("")+
  ylab("Fungal Richness")
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-4-3.png)<!-- -->

``` r
 #position jitter dodge keeps the point away from each other
  #geom_point(position=position_dodge(width=0.9))   #width determines the distance from the boxplot
```

``` r
#Lines
#group makes fungicide as the grouping variable which means that we will be able to draw the line in between one to other.
ggplot(bull.richness.soy.no.till,aes(x=GrowthStage,y=richness,group=Fungicide,color=Fungicide))+
    stat_summary(fun=mean,geom="line")+
  stat_summary(fun.data=mean_se,geom="errorbar")+
  xlab("")+
  ylab("Fungal Richness")
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
#faceting if we want to show the difference in interactions
#If we want to do the facet wrap based on the treatment
ggplot(bull.richness,aes(x=GrowthStage, y=richness, group=Fungicide, color=Fungicide))+
  stat_summary(fun=mean,geom="line")+
  stat_summary(fun.data=mean_se,geom="errorbar")+
  xlab("")+
  ylab("Fungal Richness")+
  facet_wrap(~Crop*Treatment, scales="free")  
```

![](Coding-Visualization-Assignment_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
#we can change the scale of even only x axis using free_x
```

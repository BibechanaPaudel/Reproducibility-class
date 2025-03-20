# Question 1

Download two .csv files from Canvas called DiversityData.csv and
Metadata.csv, and read them into R using relative file paths.

``` r
diversity<-read.csv("Data wrangling/DiversityData.csv", na.strings="na")
meta<-read.csv("Data wrangling/Metadata.csv",na.strings="na")
```

# Question 2

Join the two dataframes together by the common column ‘Code’. Name the
resulting dataframe alpha.

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
alpha<-(left_join(diversity, meta, by = "Code"))  #used the left join function for joining by column Code
```

# Question 3

Calculate Pielou’s evenness index: Pielou’s evenness is an ecological
parameter calculated by the Shannon diversity index (column Shannon)
divided by the log of the richness column. a. Using mutate, create a new
column to calculate Pielou’s evenness index. b. Name the resulting
dataframe alpha_even.

``` r
alpha_even<-mutate(alpha,even=shannon/log(richness))  #mutate function add a new column
```

# Question 4

Using tidyverse language of functions and the pipe, use the summarise
function and tell me the mean and standard error evenness grouped by
crop over time. a. Start with the alpha_even dataframe b. Group the
data: group the data by Crop and Time_Point. c. Summarize the data:
Calculate the mean, count, standard deviation, and standard error for
the even variable within each group. d. Name the resulting dataframe
alpha_average

``` r
alpha_average<-alpha_even %>%    #used pipe function %>% 
  group_by(Crop,Time_Point) %>%     #grouped by Crop and time point
  summarise(mean.even=mean(even),
            n=n(),
            sd.dev=sd(even)) %>% 
  mutate(std.err=sd.dev/sqrt(n))
```

    ## `summarise()` has grouped output by 'Crop'. You can override using the
    ## `.groups` argument.

# Question 5

Calculate the difference between the soybean column, the soil column,
and the difference between the cotton column and the soil column a.
Start with the alpha_average dataframe b. Select relevant columns:
select the columns Time_Point, Crop, and mean.even. c. Reshape the data:
Use the pivot_wider function to transform the data from long to wide
format, creating new columns for each Crop with values from mean.even.
d. Calculate differences: Create new columns named diff.cotton.even and
diff.soybean.even by calculating the difference between Soil and Cotton,
and Soil and Soybean, respectively. e. Name the resulting dataframe
alpha_average2

``` r
alpha_average2<-alpha_average %>% 
  select(Time_Point, Crop, mean.even) %>% 
  pivot_wider(names_from=Crop, values_from=mean.even) %>% 
  mutate(diff.cotton.even= Soil-Cotton) %>% 
  mutate(diff.soybean.even=Soil-Soybean)
```

# Question 6

Connecting it to plots a. Start with the alpha_average2 dataframe b.
Select relevant columns: select the columns Time_Point,
diff.cotton.even, and diff.soybean.even. c. Reshape the data: Use the
pivot_longer function to transform the data from wide to long format,
creating a new column named diff that contains the values from
diff.cotton.even and diff.soybean.even. i. This might be challenging, so
I’ll give you a break. The code is below.

pivot_longer(c(diff.cotton.even, diff.soybean.even), names_to = “diff”)

4.  Create the plot: Use ggplot and geom_line() with ‘Time_Point’ on the
    x-axis, the column ‘values’ on the y-axis, and different colors for
    each ‘diff’ category. The column named ‘values’ come from the
    pivot_longer. The resulting plot should look like the one to the
    right.

``` r
alpha_average2 %>% 
  select(Time_Point, diff.cotton.even, diff.soybean.even) %>% 
  pivot_longer(c(diff.cotton.even, diff.soybean.even), names_to = "diff") %>% 
  ggplot(aes(Time_Point, value, colour=diff))+
  geom_line()+
  theme_classic()+
  xlab("Time (hrs)")+    #label the x-axis
  ylab("Difference from soil in Pielou's evenness")   #label the y-axis
```

![](In-class-assignment-data-wrangling_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

# Question 7

Commit and push a gfm .md file to GitHub inside a directory called
Coding Challenge 5. Provide me a link to your github written as a
clickable link in your .pdf or .docx

[Coding Challenge
5](https://github.com/BibechanaPaudel/Reproducibility-class)

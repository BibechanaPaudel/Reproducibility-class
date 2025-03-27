# Question 1

Regarding reproducibility, what is the main point of writing your own
functions and iterations? Answer: Writing our own function and
iterations will help to reduce the copy and paste error in the case we
have to use the same code on different data. Also, we can easily modify
the code if we have our own function. To add, the iterations will help
to handle the large data more efficiently.

# Question 2

In your own words, describe how to write a function and a for loop in R
and how they work. Give me specifics like syntax, where to write code,
and how the results are returned. Answer: In R, to write a function, I
start by giving the name of the function and use the function() to
define function, inside the paranthesis , I give the input values that
function will use. The function() is followed by the curly bracket where
we write the code. For example: bp\<-function(a, b){ result\<-a+b } Here
bp is the name to the function, and a and b are the input variable that
will be used when the function is called. Likewise, for the for loop in
R: for(i in 1:10){ print(i\*3) } Here, the keyword to start the loop is
for. i is the loop variable and 1:10 specifies the range followed by the
curly bracket inside which we have our code to be executed. This loop
will print 3 times 1 to 3 times 10 ,one at a time.

This dataset contains the population and coordinates (latitude and
longitude) of the 40 most populous cities in the US, along with Auburn,
AL. Your task is to create a function that calculates the distance
between Auburn and each other city using the Haversine formula. To do
this, you’ll write a for loop that goes through each city in the dataset
and computes the distance from Auburn. Detailed steps are provided
below.

# Question 3

Read in the Cities.csv file from Canvas using a relative file path.

``` r
Cities<-read.csv("Iteration_function/Cities.csv", na.strings = "na")
```

# Question 4

Write a function to calculate the distance between two pairs of
coordinates based on the Haversine formula (see below). The input into
the function should be lat1, lon1, lat2, and lon2. The function should
return the object distance_km. All the code below needs to go into the
function.

\#convert to radians rad.lat1 \<- lat1 \* pi/180 rad.lon1 \<- lon1 \*
pi/180 rad.lat2 \<- lat2 \* pi/180 rad.lon2 \<- lon2 \* pi/180

\#Haversine formula delta_lat \<- rad.lat2 - rad.lat1 delta_lon \<-
rad.lon2 - rad.lon1 a \<- sin(delta_lat / 2)^2 + cos(rad.lat1) \*
cos(rad.lat2) \* sin(delta_lon / 2)^2 c \<- 2 \* asin(sqrt(a))

\#Earth’s radius in kilometers earth_radius \<- 6378137

\#Calculate the distance distance_km \<- (earth_radius \* c)/1000

``` r
distance_km<-function(lat1, lon1, lat2, lon2){
 rad.lat1 <- lat1 * pi/180
rad.lon1 <- lon1 * pi/180
rad.lat2 <- lat2 * pi/180
rad.lon2 <- lon2 * pi/180

# Haversine formula
delta_lat <- rad.lat2 - rad.lat1
delta_lon <- rad.lon2 - rad.lon1
a <- sin(delta_lat / 2)^2 + cos(rad.lat1) * cos(rad.lat2) * sin(delta_lon / 2)^2
c <- 2 * asin(sqrt(a)) 

# Earth's radius in kilometers
earth_radius <- 6378137
distance_km <- (earth_radius * c)/1000
return(distance_km)
}
distance_km(1,2,3,4)
```

    ## [1] 314.7552

# Question 5

Using your function, compute the distance between Auburn, AL and New
York City a. Subset/filter the Cities.csv data to include only the
latitude and longitude values you need and input as input to your
function. b. The output of your function should be 1367.854 km

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
  distance<-Cities %>% 
    filter((city=="Auburn" & state_id=="AL")|(city=="New York" & state_id=="NY")) %>%
    select("state_id", "lat", "long") %>%
    pivot_wider(names_from=state_id, values_from=c(lat,long)) %>% 
    mutate(AL_to_NY=distance_km(lat_AL,long_AL, lat_NY, long_NY)) 
distance$AL_to_NY
```

    ## [1] 1367.854

# Question 6

Now, use your function within a for loop to calculate the distance
between all other cities in the data. The output of the first 9
iterations is shown below. \##\[1\] 1367.854 \##\[1\] 3051.838 \##\[1\]
1045.521 \##\[1\] 916.4138 \##\[1\] 993.0298 \##\[1\] 1056.022 \##\[1\]
1239.973 \##\[1\] 162.5121 \##\[1\] 1036.99

``` r
for (i in seq_along(Cities$city)) {
      lat1 <- Cities$lat[Cities$city=="Auburn"]
      lon1 <- Cities$long[Cities$city=="Auburn"]
      lat2<-Cities$lat[i]
      lon2<-Cities$lon[i]
     # Call dist function directly and store the result
      distancekm <- distance_km(lat1, lon1, lat2, lon2)
       # Print the distance
      print(distancekm)

    }
```

    ## [1] 1367.854
    ## [1] 3051.838
    ## [1] 1045.521
    ## [1] 916.4138
    ## [1] 993.0298
    ## [1] 1056.022
    ## [1] 1239.973
    ## [1] 162.5121
    ## [1] 1036.99
    ## [1] 1665.699
    ## [1] 2476.255
    ## [1] 1108.229
    ## [1] 3507.959
    ## [1] 3388.366
    ## [1] 2951.382
    ## [1] 1530.2
    ## [1] 591.1181
    ## [1] 1363.207
    ## [1] 1909.79
    ## [1] 1380.138
    ## [1] 2961.12
    ## [1] 2752.814
    ## [1] 1092.259
    ## [1] 796.7541
    ## [1] 3479.538
    ## [1] 1290.549
    ## [1] 3301.992
    ## [1] 1191.666
    ## [1] 608.2035
    ## [1] 2504.631
    ## [1] 3337.278
    ## [1] 800.1452
    ## [1] 1001.088
    ## [1] 732.5906
    ## [1] 1371.163
    ## [1] 1091.897
    ## [1] 1043.273
    ## [1] 851.3423
    ## [1] 1382.372
    ## [1] 0

Bonus point if you can have the output of each iteration append a new
row to a dataframe, generating a new column of data. In other words, the
loop should create a dataframe with three columns called city1, city2,
and distance_km, as shown below. The first six rows of the dataframe are
shown below.

``` r
distance_df<-NULL

for (i in seq_along(Cities$city)) {
      lat1 <- Cities$lat[Cities$city=="Auburn"]
      lon1 <- Cities$long[Cities$city=="Auburn"]
      lat2<-Cities$lat[i]
      lon2<-Cities$lon[i]
     # Call dist function directly and store the result
      distancekm <- distance_km(lat1, lon1, lat2, lon2)
       # Print the distance
      distance_df<-rbind(distance_df,data.frame(
        city1 = "Auburn",
          city2 = Cities$city[i],
          distance_km = distancekm
      ))

    }
distance_df
```

    ##     city1         city2 distance_km
    ## 1  Auburn      New York   1367.8540
    ## 2  Auburn   Los Angeles   3051.8382
    ## 3  Auburn       Chicago   1045.5213
    ## 4  Auburn         Miami    916.4138
    ## 5  Auburn       Houston    993.0298
    ## 6  Auburn        Dallas   1056.0217
    ## 7  Auburn  Philadelphia   1239.9732
    ## 8  Auburn       Atlanta    162.5121
    ## 9  Auburn    Washington   1036.9900
    ## 10 Auburn        Boston   1665.6985
    ## 11 Auburn       Phoenix   2476.2552
    ## 12 Auburn       Detroit   1108.2288
    ## 13 Auburn       Seattle   3507.9589
    ## 14 Auburn San Francisco   3388.3656
    ## 15 Auburn     San Diego   2951.3816
    ## 16 Auburn   Minneapolis   1530.2000
    ## 17 Auburn         Tampa    591.1181
    ## 18 Auburn      Brooklyn   1363.2072
    ## 19 Auburn        Denver   1909.7897
    ## 20 Auburn        Queens   1380.1382
    ## 21 Auburn     Riverside   2961.1199
    ## 22 Auburn     Las Vegas   2752.8142
    ## 23 Auburn     Baltimore   1092.2595
    ## 24 Auburn     St. Louis    796.7541
    ## 25 Auburn      Portland   3479.5376
    ## 26 Auburn   San Antonio   1290.5492
    ## 27 Auburn    Sacramento   3301.9923
    ## 28 Auburn        Austin   1191.6657
    ## 29 Auburn       Orlando    608.2035
    ## 30 Auburn      San Juan   2504.6312
    ## 31 Auburn      San Jose   3337.2781
    ## 32 Auburn  Indianapolis    800.1452
    ## 33 Auburn    Pittsburgh   1001.0879
    ## 34 Auburn    Cincinnati    732.5906
    ## 35 Auburn     Manhattan   1371.1633
    ## 36 Auburn   Kansas City   1091.8970
    ## 37 Auburn     Cleveland   1043.2727
    ## 38 Auburn      Columbus    851.3423
    ## 39 Auburn         Bronx   1382.3721
    ## 40 Auburn        Auburn      0.0000

\##City1 City2 Distance_km \##1 New York Auburn 1367.8540 \##2 Los
Angeles Auburn 3051.8382 \##3 Chicago Auburn 1045.5213 \##4 Miami Auburn
916.4138 \##5 Houston Auburn 993.0298 \##6 Dallas Auburn 1056.0217

# Question 7

Commit and push a gfm .md file to GitHub inside a directory called
Coding Challenge 6. Provide me a link to your github written as a
clickable link in your .pdf or .docx

[Github](https://github.com/BibechanaPaudel/Reproducibility-class/tree/main/Iteration_function)

[md_file](https://github.com/BibechanaPaudel/Reproducibility-class/blob/main/Iteration_function/Coding_challenge_6.md)

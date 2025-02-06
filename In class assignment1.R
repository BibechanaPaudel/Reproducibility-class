#Create a vector named 'z' with the values 1 to 200
z<-c(1:200)
#Print the mean and standard deviation of z on the console
mean(z) #mean
sd(z) #standard deviation
#Create a logical vector named zlog that is 'TRUE' for z values greater than 30 and 'FALSE' otherwise.
zlog<-z>30
print(zlog)
#Make a dataframe with z and zlog as columns. Name the dataframe zdf
zdf<-data.frame(z,zlog)
#Change the column names in your new dataframe to equal “zvec” and “zlogic”
colnames(zdf)<-c("zvec","zlogic")
#Make a new column in your dataframe equal to zvec squared (i.e., z2). Call the new column zsquared.
zdf$zsquared<-zdf$zvec^2
#Subset the dataframe with and without the subset() function to only include values of zsquared greater than 10 and less than 100
zdfsubset1<-subset(zdf,zsquared>10 & zsquared<100) #with subset function
zdfsubset2<-zdf[zdf$zsquared>10 & zdf$zsquared<100,] #without subset function
#Subset the zdf dataframe to only include the values on row 26
zdfsubset3<-zdf[26,]
#Subset the zdf dataframe to only include the values in the column zsquared in the 180th row.
zdfsubset4<-zdf$zsquared[180]
#Annotate your code, commit the changes and push it to your GitHub
#Download the Tips.csv file from Canvas. Use the read.csv() function to read the data into R so that the missing values are properly coded. **Note the missing values  reported in the data as a period (i.e., “.”). How do you know the data were read correctly?
data<-read.csv("C:/Users/paude/Downloads/TipsR.csv", na.strings = ".")
str(data)
summary(data)
#To know that the data were read correctly we can check the structure and summary of the data.We can also see the data by clicking it in the environment that will open our file and we can check if the data is correct or not.  

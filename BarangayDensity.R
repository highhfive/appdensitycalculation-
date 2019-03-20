##Calculates Area of Barangay
region=read.csv("regionarea.csv")
population=read.csv("population.csv")
library(dplyr)
df1<-select(population,Region,Barangay)
df2<-select(region,Region,Area)
df2$count<-with(df1,table(Region))
df2$bararea<-with(df2,Area/count)

##Extracts the Top 5 Barangay with highest densities to CSV file
orderedByDensity <- arrange(df2, desc(bararea))
top5BarangayDensities <- slice(orderedByDensity, c(1:5))
write.csv(top5BarangayDensities, 'top5BarangayDensities.csv')

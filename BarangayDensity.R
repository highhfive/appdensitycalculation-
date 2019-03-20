##Calculates Area of Barangay
region=read.csv("regionarea.csv")
population=read.csv("population.csv")
library(dplyr)
df1<-select(population,Region,Barangay)
df2<-select(region,Region,Area)
df2$count<-with(df1,table(Region))
df2$bararea<-with(df2,Area/count)

df2

PopulationDensity<-merge(x=population, y=df2, by = "Region", all.x=TRUE)
PopulationDensity[,"pop_density"]<-PopulationDensity[,"Population"]/PopulationDensity[,"bararea"]
head(PopulationDensity)

FinalPopDensity<-PopulationDensity[,c("Region","Province","Barangay","pop_density")]
head(FinalPopDensity)
ArrangedPD<-arrange(FinalPopDensity, desc(pop_density))
head(ArrangedPD)

##Extracts the Top 5 Barangay with highest densities to CSV file
orderedByDensity <- arrange(ArrangedPD, desc(pop_density))
top5BarangayDensities <- slice(orderedByDensity, c(1:5))
write.csv(top5BarangayDensities, 'top5BarangayDensities.csv')


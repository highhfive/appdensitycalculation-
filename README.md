# App Density Calculation

## Barangay Density Calculations

### This code snippet will result in a data frame of the area of each barangay.
```R
##Calculates Area of Barangay
region=read.csv("regionarea.csv")
population=read.csv("population.csv")
library(dplyr)
df1<-select(population,Region,Barangay)
df2<-select(region,Region,Area)
df2$count<-with(df1,table(Region))
df2$bararea<-with(df2,Area/count)
```

### This will result in a data frame of the population density of each barangay.
```R
PopulationDensity<-merge(x=population, y=df2, by = "Region", all.x=TRUE)
PopulationDensity[,"pop_density"]<-PopulationDensity[,"Population"]/PopulationDensity[,"bararea"]
head(PopulationDensity)

FinalPopDensity<-PopulationDensity[,c("Region","Province","Barangay","pop_density")]
head(FinalPopDensity)
ArrangedPD<-arrange(FinalPopDensity, desc(pop_density))
head(ArrangedPD)
```
### This will extract the top 5 population densities among all the barangays and save it in a CSV
```R
##Extracts the Top 5 Barangay with highest densities to CSV file
orderedByDensity <- arrange(ArrangedPD, desc(pop_density))
top5BarangayDensities <- slice(orderedByDensity, c(1:5))
write.csv(top5BarangayDensities, 'top5BarangayDensities.csv')
```

## City Density Calculations

Group 5
* Migo Dancel
* Lasmyr Edullantes
* Danna Ashley Mayo
* Michaela Miranda
* Alexis Carlos Ramos

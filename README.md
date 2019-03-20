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
We achieved this by using the with() function to calculate the area of the barangays within the region through the Area/barangay count(count)

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
To calculate for the population of each barangay, we will be using the population of each barangay(Population)/the area of the barangays per region (bararea)

### This will extract the top 5 population densities among all the barangays and save it in a CSV
```R
##Extracts the Top 5 Barangay with highest densities to CSV file
orderedByDensity <- arrange(ArrangedPD, desc(pop_density))
top5BarangayDensities <- slice(orderedByDensity, c(1:5))
write.csv(top5BarangayDensities, 'top5BarangayDensities.csv')
```
We will then take the first 5 rows of the arranged (descending) data frame of the population density for all barangays (ArrangedPD) and then write to CSV with a base R function

## City Density Calculations
```R

```

### This will result in a data frame of the area of each city
```R

```

### This will result in a data frame of the population density of each city
```R

```

### This will extract the top 5 population densities among all the cities and save it in a CSV
```R

```

Group 5
* Migo Dancel
* Lasmyr Edullantes
* Danna Ashley Mayo
* Michaela Miranda
* Alexis Carlo Ramos

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

### This will result in a data frame of the area of each city
```R
##Calculates Area of Barangay
region=read.csv("regionarea.csv")
population=read.csv("population.csv")
library(dplyr)
library(plyr)
head(region)
head(population)

# Counting # of cities
df3<-select(population, Region, CityProvince)
City_count<-count(df3, "CityProvince")
City_count

# Put back count to data frame with city label, count will print as 'freq'
x<-merge(x=df3, y=City_count, by="CityProvince")
head(x)
y<-cbind(x, population$Population)
head(y)

#Put back into data frame the area per region and calculate area by city, city area will pritn as 'new'
CityCount_Pop<-merge(x=region, y=y, by="Region")
head(CityCount_Pop)
CityCount_Pop[,"City_PopDen"]<-CityCount_Pop[,"Area"]/CityCount_Pop[,"freq"]
head(CityCount_Pop)
```

### This will result in a data frame of the population density of each city
```R
#Calculating Population per City
group_by(CityCount_Pop, CityProvince)
City_Pop<-aggregate(population$Population, by=list(CityProvince=population$CityProvince), FUN=sum)
head(City_Pop)

#merge population and area
City_Area<-aggregate(CityCount_Pop$City_PopDen, by=list(CityProvince=CityCount_Pop$CityProvince), FUN=sum)
head(City_Area)
City_Pop_Area<-merge(City_Pop, City_Area, by="CityProvince")
head(City_Pop_Area)


#Calculating population density per city
PopDen1<-City_Pop_Area$x.x/City_Pop_Area$x.y
PopDen1
PopDenMerge<-cbind(City_Pop_Area, PopDen1)
head(PopDenMerge)
PopDen_bycity<-arrange(PopDenMerge, desc(PopDenMerge$PopDen1))
head(PopDen_bycity)
```

### This will extract the top 5 population densities among all the cities and save it in a CSV
```R
##Extracts the Top 5 City with highest densities to CSV file
orderedByDensity <- arrange(df2, desc(CityCount_Pop))
top5CityDensities <- slice(orderedByDensity, c(1:5))
write.csv(top5CityDensities, 'top5CityDensities.csv')
```

Group 5
* Migo Dancel
* Lasmyr Edullantes
* Danna Ashley Mayo
* Michaela Miranda
* Alexis Carlo Ramos

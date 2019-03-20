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



##Extracts the Top 5 City with highest densities to CSV file
top5CityDensities <- slice(PopDen_bycity, c(1:5))
write.csv(top5CityDensities, 'top5CityDensities.csv')

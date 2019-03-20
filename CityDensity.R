##Calculates Area per City

##Calculates Density per city

##Extracts the Top 5 City with highest densities to CSV file
orderedByDensity <- arrange(df2, desc(cityarea))
top5CityDensities <- slice(orderedByDensity, c(1:5))
write.csv(top5CityDensities, 'top5CityDensities.csv')

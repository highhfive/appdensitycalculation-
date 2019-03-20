region=read.csv("regionarea.csv")
population=read.csv("population.csv")
library(dplyr)
df1<-select(population,Region,Barangay)
df2<-select(region,Region,Area)
df2$count<-with(df1,table(Region))
df2$bararea<-with(df2,Area/count)

df2

PopulationDensity<-merge(x=population, y=df2, by = "Region", all.x=TRUE)
PopulationDensity[,"pop_density"]<-PopulationDensity[,"bararea"]/PopulationDensity[,"Population"]
head(PopulationDensity)

FinalPopDensity<-PopulationDensity[,c("Region","Province","Barangay","pop_density")]
head(FinalPopDensity)
ArrangedPD<-arrange(FinalPopDensity, desc(pop_density))
head(ArrangedPD)


library(ggplot2)

##load the database
NEI <- readRDS("summarySCC_PM25.rds",)

## subset the data that include related to Baltimore City
q3db<- NEI[which(NEI$fips == "24510"),]

##plotting 
par(mfrow = c(1,1),mar=c(5,5,4,4))
qplot(year,Emissions,facets=.~type,
         data=q3db,
         geom="bar",
         stat="identity",
         position="identity",
         width=1.67,
         fill=year,
         main = "Total Emissions from PM2.5 in the Baltimore By Types Of Sources ",font.main = 3, 
         ylab="TotalPM2.5 Emission in Kilo"
         )

dev.copy(png,file="plot3.png",width = 600, height = 480, 
         units = "px", bg = "transparent")
dev.off()

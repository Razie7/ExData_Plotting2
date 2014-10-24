
##load the database
NEI <- readRDS("summarySCC_PM25.rds",)

## subset the data that include related to Baltimore City
q2db<- NEI[which(NEI$fips == "24510"),]

##find the total sum of emissions for each year
Q2sumemission<-aggregate(q2db$Emissions,by=list(q2db$year), sum)
colnames(Q2sumemission)<-c("year","Emissions")

##  using 
png("plot2.png",width = 600, height = 480, 
    units = "px", ) 
par(mfrow = c(1,1),mar=c(5,5,4,4))
barplot(xtabs
        (as.integer(Q2sumemission$Emissions)/1000~Q2sumemission$year),
        main = "Total Emissions in the Baltimore City ",font.main = 3,
        xlab="Year",
        ylab="Total Emissions PM2.5 in Kilo",
        col="burlywood")

dev.off()

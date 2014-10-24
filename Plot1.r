
##load the database
NEI <- readRDS("summarySCC_PM25.rds",)

##find the total sum of emissions for each year
Q1sumemission<-aggregate(NEI$Emissions,by=list(NEI$year), sum)
colnames(Q1sumemission)<-c("year","Emissions")

## Plotting the graph (using the bar chart)
png("plot1.png",width = 600, height = 480, 
    units = "px", ) 
par(mfrow = c(1,1),mar=c(5,5,4,4))

barplot(xtabs
        (as.integer(Q1sumemission$Emissions)/1000~Q1sumemission$year),
        xlab="Year",
        ylab="Total PM2.5 emission From All Sources in Kilo",
        main = "Total Emissions from PM2.5 in the United States",font.main = 3, 
        col="darkolivegreen1")
dev.off()

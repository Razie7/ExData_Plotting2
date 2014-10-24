
## Load the databases
NEI <- readRDS("summarySCC_PM25.rds",)
SCC <- readRDS("Source_Classification_Code.rds")

## subset rows related to Road 
Q5<- SCC[grep("On-Road",SCC$EI.Sector),1:5]

Q5SCC<-as.character(Q5$SCC)

SelMV<-NEI[NEI$SCC%in%Q5SCC,]
## select data for Baltimore City FIPS=24510 
Q5data<- SelMV[which(SelMV$fips == "24510"),]

Q5sumEmissions<-aggregate(Q5data$Emissions, by = list(year=Q5data$year),sum)

colnames(Q5sumEmissions)<-c("year","Emissions")
#plotting
par(mfrow = c(1,1),mar=c(5,5,4,4))
barplot(xtabs(as.integer(Q5sumEmissions$Emissions)/1000~Q5sumEmissions$year),
       main = "Total PM2.5 Emission From Motor-Vehicle Sources In Baltimore",font.main = 3,
        xlab="Year",
        ylab="TotalPM2.5 Emission in Kilo",
       
        col="red",
        width=c(2,2,2,2)
        ) 

## save the plot
dev.copy(png,file="plot5.png",width = 600, height = 480, 
         units = "px", bg = "transparent")
dev.off()

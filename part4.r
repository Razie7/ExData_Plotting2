
## Load the databases
NEI <- readRDS("summarySCC_PM25.rds",)
SCC <- readRDS("Source_Classification_Code.rds")

## from EI.Sector column subset values that contain "coal"

data<- SCC[grep("Coal",SCC$EI.Sector),1:5]
coal<-as.character(data$SCC)

##subset the data from NEI with emission based on coal extracted data

selectedcoal<-NEI[NEI$SCC %in% coal,]

#claculate the total emissions in each year
sumEmissions<-aggregate(selectedcoal$Emissions, by = list(year=selectedcoal$year),sum)
colnames(sumEmissions)<-c("year","Emissions")
#plotting
par(mfrow = c(1,1),mar=c(5,5,4,4))
barplot(xtabs(as.integer(sumEmissions$Emissions)/1000~sumEmissions$year),
        xlab="year",
        col="lightblue",
        main = "Total Emissions from Coal combustion-related sources ",font.main = 3,
        ylab="Total CoalCombusion-related Emissions in Kilo")

## save the plot
dev.copy(png,file="plot4.png",width = 600, height = 480, 
         units = "px", bg = "transparent")
dev.off()

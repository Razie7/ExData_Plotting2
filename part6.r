## Load the databases
NEI <- readRDS("summarySCC_PM25.rds",)
SCC <- readRDS("Source_Classification_Code.rds")

### extract rows that related to  fips Los Angeles County == "06037" !!!
Q6<- SCC[grep("On-Road",SCC$EI.Sector),1:5]
Q6SCC<-as.character(Q6$SCC)

#subset the data from NIE based on the road fetch data
SelMV<-NEI[NEI$SCC%in%Q6SCC,]
Q6data<- SelMV[which(SelMV$fips == "06037"| SelMV$fips == "24510"),]

## FInd the sum of the emissions for each year 
Q6sumEmissions<-aggregate(Q6data$Emissions, by = list(year=Q6data$year,fips=Q6data$fips),sum)

colnames(Q6sumEmissions)<-c("year","fips","Emissions")
Q6sumEmissions$fips<-gsub("06037","Los Angeles County",Q6sumEmissions$fips)
Q6sumEmissions$fips<-gsub("24510","Baltimore",Q6sumEmissions$fips)
#plotting
library(ggplot2)
par(mfrow = c(1,1),mar=c(5,5,4,4))
qplot(
        data=Q6sumEmissions,
        x=year,
        y=Emissions/1000,
        ylab="Total Pm2.5 Emission in (Kilo)",
        xlab="Year",
        fill=fips,
        geom="bar",
        stat="identity",
        position=position_dodge(width=1),
        main = "Comparison Between Los Angeles and Baltimore",
        width=1
        )
## save the plot
dev.copy(png,file="plot6.png",width = 480, height = 480, 
         units = "px", bg = "transparent")
dev.off()

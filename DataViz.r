#Loading Packages
library(ggplot2)
library(data.table)
library(readr)
library(ggthemes)

#Reading in the CSV file into a data frame
df <- fread(file="CSV Files/Economist_Assignment_Data.csv",drop=1)

#Creating a Scatter Plot with the data (open circles with color determined by region)
pl <- ggplot(df,aes(x=CPI,y=HDI)) + geom_point(shape=1,aes(color=Region),size=3)
#Adding a trendline
pl2 <- pl + geom_smooth(aes(group=1),method='lm',formula=y~log(x),se=F,color='red')
#Subsetting a group of countries to label
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan","Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                             "India", "Italy", "China", "South Africa", "Spane",
                             "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                             "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                             "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20",data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)
#Setting "The Economist" Theme and the X Axis
pl4 <- pl3 + theme_economist_white() + scale_x_continuous(name='Corruption Perceptions Index, 2011 (10=least corrupt)',limits=c(1,10),breaks=1:10)
#Setting the Y Axis and the Title
pl5 <- pl4 + scale_y_continuous(name='Human Development Index, 2011 (1=Best)', limits=c(0.2,1),breaks=c(0.2,0.4,0.6,0.8,1.0)) + ggtitle('Corruption and Human Development')
print(pl5)

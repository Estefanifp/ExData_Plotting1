## IMPORTANT! : This code was created with R version 3.1.1, on Windows SO
## when running the code on Mac or other SO you may need to set the method = "curl" in download.file


## Check if the data is downloaded in the working directory, if not download it.

if (!file.exists ("household_power_consumption.txt")) {
        download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                       destfile = "household_power_consumption.zip")
        dateDownloaded <- date()
        unzip ("household_power_consumption.zip")
}  

## Read the data.

        data <- read.table ("household_power_consumption.txt", na.strings = "?", sep = ";", header = TRUE)
        data [,1] <- as.character (data[,1])  
        data [,2] <- as.character (data[,2])
        
## Extract only the information required on 2 specific days.

        finaldata <- subset (data[(data[,1] == "1/2/2007" | data[,1] == "2/2/2007"), ])        

## Concatenate Date and Time and format it as POSIXlt

        finaldata$Date <- strptime(paste(finaldata$Date, finaldata$Time), "%d/%m/%Y %H:%M:%S" )
        Sys.setlocale("LC_TIME", "English")

## Generate the plot and save it as a png file.

png ( file = "plot1.png", width = 480, height = 480, units = "px", res = 100)
hist (finaldata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

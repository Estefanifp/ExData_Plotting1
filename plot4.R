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

## Generate the 4 plots and save them as a png file.

png (file = "plot4.png", height = 480, width = 480, res = 100, units = "px")
par (mfrow = c(2,2))
with (finaldata, {
        plot (finaldata$Date, finaldata$Global_active_power, ylab = "Global Active Power", xlab= "", pch = "")
                lines (finaldata$Date, finaldata$Global_active_power)
        plot (finaldata$Date, finaldata$Voltage, ylab = "Voltage", xlab = "datetime", pch = "")
                lines (finaldata$Date, finaldata$Voltage)
        with (finaldata, plot (finaldata$Date, finaldata$Sub_metering_1, ylab = "Energy sub metering", xlab = "", pch = ""))
                lines (finaldata$Date, finaldata$Sub_metering_1, col = "black")
                lines (finaldata$Date, finaldata$Sub_metering_2, col = "red")
                lines (finaldata$Date, finaldata$Sub_metering_3, col = "blue")
                legend ("topright", lty = "solid", cex = .25, col = c("black", "red", "blue"), legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot (finaldata$Date, finaldata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", pch = "")
                lines (finaldata$Date, finaldata$Global_reactive_power, lty = "solid")
})
dev.off ()
pollutantmean <- function(directory, pollutant, id = 1:332) {
    dataframes <- vector(mode="list", length=length(id))
    for (x in id) {
        filename <- paste(directory,"/",sprintf("%03d", x),".csv",sep="")
        df <- read.csv(filename)
        dataframes[[x]] <- df
    }
    df <- do.call("rbind",dataframes)
    mean(df[[pollutant]], na.rm = TRUE)
}
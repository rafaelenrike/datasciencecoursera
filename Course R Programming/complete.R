complete <- function(directory, id = 1:332) {
    dataframes <- vector(mode="list", length=length(id))
    for (x in id) {
        filename <- paste(directory,"/",sprintf("%03d", x),".csv",sep="")
        d <- read.csv(filename)
        ok <- sum(complete.cases(d))
        dataframes[[x]] <- data.frame(id = x, nobs = ok)
    }
    df <- do.call("rbind",dataframes)
    df
}
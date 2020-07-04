corr <- function(directory, threshold = 0) {
    comp <- complete("specdata")
    x <- comp[comp$nobs > threshold,]
    ids <- x$id
    dataframes <- vector(mode="list", length=length(ids))
    correlations <- numeric(length(ids))
    cont <- 1
    for (i in ids) {
        filename <- paste(directory,"/",sprintf("%03d", i),".csv",sep="")
        d <- read.csv(filename)
        good <- complete.cases(d)
        df <- d[good,]
        correlations[cont] <- cor(df$sulfate, df$nitrate)
        cont <- cont + 1
    }
    correlations
}
rankall <- function(outcome, num = "best") {
    # Reading data
    data <- read.csv("outcome-of-care-measures.csv", colClasses="character")

    # Selecting only the columns needed
    data <- data[c(2,7,11,17,23)]

    # Changing column names to simpler ones
    names(data)[1] <- "hospital"
    names(data)[2] <- "state"
    names(data)[3] <- "heart attack"
    names(data)[4] <- "heart failure"
    names(data)[5] <- "pneumonia"

    # Validating outcome
    outcome_names <- c("heart attack", "heart failure", "pneumonia")
    if (outcome %in% outcome_names == FALSE) stop("Invalid outcome")

    ## Validating the num value
    if(num != "best" && num != "worst" && num%%1 != 0) stop("invalid num")

    # Selecting the rows from all states with a valid outcome
    data <- data[data[outcome] != 'Not Available', ]

    # Convert the outcome data to numeric for ordering purposes
    data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))

    # Ordering the data
    data <- data[order(data$hospital, decreasing = FALSE), ]
    data <- data[order(data[outcome], decreasing = FALSE), ]

    # Helper function to process hospital by rank
    getHospByRank <- function(df, s, n) {
        df <- df[df$state==s, ]
        vals <- df[, outcome]
        if(n == "best") {
            rowNum <- which.min(vals)
        } else if(n == "worst" ) {
            rowNum <- which.max(vals)
        } else {
            rowNum <- n
        }
        df[rowNum, ]$hospital
    }

    states <- unique(data[,2])

    newdata <- data.frame("hospital"=character(), "state"=character())
    for(st in states) {
        hosp <- getHospByRank(data, st, num)
        newdata <- rbind(newdata, data.frame(hospital=hosp, state=st))
    }
        
    ## Return a data frame with the hospital names and the (abbreviated) 
    ## state name
    newdata <- newdata[order(newdata['state'], decreasing = FALSE), ]
    newdata
}
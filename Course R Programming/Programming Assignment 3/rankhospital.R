rankhospital <- function(state, outcome, num = "best") {
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

    # Validating state
    states <- unique(data[,2])
    if (state %in% states == FALSE) stop("Invalid state")

    ## Validating the num value
    if(num != "best" && num != "worst" && num%%1 != 0) stop("invalid num")

    # Selecting the rows from state received and has a valid outcome
    data <- data[data$state == state & data[outcome] != "Not Available", ]

    # Convert the outcome data to numeric for ordering purposes
    data[outcome] <- as.data.frame(sapply(data[outcome], as.numeric))

    # Ordering the data
    data <- data[order(data$hospital, decreasing = FALSE), ]
    data <- data[order(data[outcome], decreasing = FALSE), ]

    ## Processing the num argument for various conditions
    vals <- data[, outcome]
    if(num == "best"){
        rowNum <- which.min(vals)
    }else if(num == "worst"){
        rowNum <- which.max(vals)
    }else{
        rowNum <- num
    }
    
    ## Return hospital name in that state with lowest 30-day death rate
    data[rowNum, ]$hospital
}
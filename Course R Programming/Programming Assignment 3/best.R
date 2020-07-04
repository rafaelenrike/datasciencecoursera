best <- function(state, outcome) {
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

    # Selecting the rows from state received and has a valid outcome
    data <- data[data$state == state & data[outcome] != "Not Available", ]

    # Select the column ot the given outcome
    vals <- data[,outcome]

    # Finding the row where the number of attacks is the minimum
    rowNum <- which.min(vals)

    # Return the hospital name
    data[rowNum,]$hospital
}
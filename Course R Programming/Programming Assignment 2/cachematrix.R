## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
# Creates the special matrix that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
        
        # Atribute: inverse (initialization)
        i <- NULL

        # Method: set the matrix
        set <- function(matrix) {
                x <<- matrix
                i <<- NULL
        }

        # Method: get the matrix
        get <- function() {
                x
        }

        # Method: set the inverse attribute
        setInverse <- function(inverse) {
                i <<- inverse
        }

        # Method: get the inverse attribute
        getInverse <- function() {
                i
        }

        # Returns the list of methods
        list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}


## Write a short comment describing this function
# Calculates the inverse of a matrix, checking first if it's not in cache
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        m <- x$getInverse()

        if (!is.null(m)) {
                return(m)
        }

        # At this point, we know the inverse is not cached, so let's calculate it (using matrix multiplication)
        morig <- x$get()
        m <- solve(mrorig) %*% morig

        # Save the calculation in cache
        x$setInverse(m)

        # Return the matrix
        m
}

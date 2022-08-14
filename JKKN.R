
# finds jackknifed versions of vector-valued statistics

# argument:

#    x: input data, a vector or matrix
#    tFtn: a vector-valued function, whose sole argument u has the same
#          number of columns as x

jkkn <- function(x,tFtn) 
{
   if (is.vector(x)) x <- matrix(x,ncol=1)
   p <- ncol(x)
   n <- nrow(x)
   Tn <- tFtn(x)
   nTn <- n * Tn
   lT <- length(Tn)

   getPseudoVal <- function(i) nTn - (n-1) * tFtn(x[-i,])

   pseudoVals <- sapply(1:n,getPseudoVal)  # lT rows, n cols
   Tjack <- colMeans(pseudoVals)


}

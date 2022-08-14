
# finds jackknifed versions of vector-valued statistics

# argument:

#    x: input data, a vector or matrix
#    tFtn: a vector-valued function, whose sole argument u has the same
#          number of columns as x

jkkn <- function(x,tFtn) 
{
   if (is.data.frame(x)) stop('x must be a vector or matrix')
   if (is.null(dim(x))) x <- matrix(x,ncol=1)
   p <- ncol(x)
   n <- nrow(x)
   Tn <- tFtn(x)
   nTn <- n * Tn
   lT <- length(Tn)  # length of the output statistic vector

   getPseudoVal <- function(i) nTn - (n-1) * tFtn(x[-i,])
   pseudoVals <- sapply(1:n,getPseudoVal)  # lT rows, n cols

   Tjack <- rowMeans(pseudoVals)

   getSE <- function(i) sd(pseudoVals[i,]) / sqrt(n)
   SEs <- apply(pseudoVals,1,function(rw) sd(rw) / sqrt(n))

   list(Tjack = Tjack,SEs = SEs)

}


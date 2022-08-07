
# fit MM est and possible MLE

# arguments:

#    x: data to be fitted
#    MLE: if TRUE, fit both MM and MLE, otherwise just MM

#

exn <- function(x,MLE=TRUE) 
{

   mme <- MM(x)
   if (MLE) {
      require(limma)
      mle <- normexp.fit(x)
      par <- mle$par
      mle$tau <- exp(par[3]
      mle$mu <- par[1]
      mle$sig <- exp(par[2])
   } else mle <- NULL

   z <- list(mme=mmemle,mle=mle)
   class(z) <- 'exNormFit')
   z
}


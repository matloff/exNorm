
# fit MM est and possible MLE

# arguments:

#    x: data to be fitted
#    MLE: if TRUE, fit both MM and MLE, otherwise just MM



exn <- function(x,MLE=TRUE) 
{

   mme <- MM(x)
   mle <- if (MLE) mleFtn(x) else NULL

   z <- list(mme=mmemle,mle=mle)
   class(z) <- 'exNormFit'
   z
}

mmeFtn <- function(x) 
{
   library(moments) 
   m <- mean(x)
   s <- sd(x)
   gam1 <- skewness(x)
   gam3 <- (gam1/2)^(1/3)
   mu <- m - s*gam3
   sig2 <- s^2 * (1 - gam3^2)
   tau <- s * gam3
   list(tau=tau, mu=mu, sig=sqrt(sig2))
}

mleFtn <- function(x) 
{
   require(limma)
   mle <- normexp.fit(x)
   par <- mle$par
   mle$tau <- exp(par[3])
   mle$mu <- par[1]
   mle$sig <- exp(par[2])
   mle
}

rexNorm <- function(n,tau,mu,sig) 
{
   x1 <- rexp(n,1/tau)
   x2 <- rnorm(n,mu,sig)
   x1 + x2
}

# to come:

# library(gamlss.dist) 
# x <- rexNorm(100,3,2,1)
# plot(density(x))
# f <- function(x) dexGAUS(x,2,1,3)
# curve(f,0,25,add=T)


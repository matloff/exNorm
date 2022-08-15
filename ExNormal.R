
# compute Method of Moments estimator, no jackknife
exNormMMEbase <- function(x) 
{
   library(moments) 
   m <- mean(x)
   s <- sd(x)
   gam1 <- skewness(x)
   gam3 <- (gam1/2)^(1/3)
   mu <- m - s*gam3
   sig2 <- s^2 * (1 - gam3^2)
   tau <- s * gam3
   ests <- c(mu,sqrt(sig2),tau)
   names(ests) <- c('mu','sig','tau')
   ests
}
# get jackknifed est, plus standard errors
exNormMMEftn <- function(x) jkkn(x,exNormMMEbase)

# compute MLE, no jackknife
exNormMLEbase <- function(x) 
{
   require(limma)
   tmp <- normexp.fit(x)
   par <- tmp$par
   tau <- exp(par[3])
   mu <- par[1]
   sig <- exp(par[2])
   ests <- c(mu,sig,tau)
   names(ests) <- c('mu','sig','tau')
   ests
}
# unfortunately, limma() does not report standard errors
# get jackknifed est, plus standard errors
exNormMLEftn <- function(x) jkkn(x,exNormMLEbase)

# for testing

normalFtnBase <- function(x) c(mean(x),sd(x))
normalFtn <- function(x) jkkn(x,normalFtnBase)

# plot nonparametric, model-based density estimates
plotFit <- function(x,fit) 
{
    require(gamlss.dist) 
    # get nonparametric density estimate, but don't plot yet
    dx <- density(x)
    # prep to plot fitted model
    ests <- fit$Tjack
    f <- function(x) dexGAUS(x,ests[1],ests[2],ests[3])
    crv <- curve(f,min(dx$x),max(dx$x), xlab='fitted model black')
    # now plot the density estimate
    plot(dx,ylim=c(0,max(crv$y)),
       col='blue',main='assessing model fit',xlab='x, fitted model black')
    # and the fitted model
    lines(crv)
}

# generate random numbers, as with runif(), rnorm() etc.
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


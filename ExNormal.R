
# fit MM est and possible MLE

# arguments:

#    x: data to be fitted
#    MLE: if TRUE, fit both MM and MLE, otherwise just MM



exn <- function(x,MLE=TRUE) 
{

   mme <- mmeFtn(x)
   mle <- if (MLE) mleFtn(x) else NULL

   z <- list(mme=mme,mle=mle)
   class(z) <- 'exNormFit'
   z
}

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

exNormMMEftn <- function(x) jkkn(x,exNormMMEbase)

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
exNormMLEftn <- function(x) jkkn(x,exNormMLEbase)

# for testingn

normalFtnBase <- function(x) c(mean(x),sd(x))
normalFtn <- function(x) jkkn(x,normalFtnBase)

# plot nonparametric, model-based density estimates
plotExNormFit <- function(x,fit) 
{
    require(gamlss.dist) 
    dx <- density(x)
    plot(dx)
    ests <- fit$Tjack
    f <- function(x) dexGAUS(x,ests[1],ests[2],ests[3])
    curve(f,min(dx$x),max(dx$x),add=T)

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


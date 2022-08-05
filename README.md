# exNorm
Tools for the ex-normal distribution family.

The ex-normal family, often called ex-Gaussian, is so named because it
is a convolution of an exponential random variable and a Gaussian one:

W = U + V

where U has an exponential distribution, V is normally distributed, 
U and V are independent, and W is the ex-normal random variable.

This family is often used to model response times in cognitive science.

There are other packages on CRAN that can handle this family, 
but they are quite complex.  For instance, **gamlss** and **gamlss.data**
can model many different families, and the documentation in **limma** 
is specific to the genomics field.

Our goals here are:

- Provide a simple, easily accessible alternative that covers only the
  ex-normal family.

- Provide additional capabilitie not in those other packages.



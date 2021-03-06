% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rowBinomialTests.R
\name{rowBinomialTests}
\alias{rowBinomialTests}
\title{Binomial proportion tests for each row of a matrix}
\usage{
rowBinomialTests(mat, categ, alternative = c("two.sided", "less",
  "greater"), warn = TRUE)
}
\arguments{
\item{mat}{A numeric matrix whose rows correspond to variables and columns to
observations}

\item{categ}{A vector of \code{ncol(mat)} categories in \eqn{'0','1'} for the
observations}

\item{alternative}{A character string specifying the alternative hypothesis.
Must be one of "two.sided" (default), "greater" or "less". As in
\code{\link{binom.test}}, alternative = "greater" is the alternative that
class '1' is shifted to the right of class '0'.}

\item{warn}{A boolean value indicating whether to issue a warning if
\code{alternative=="two-sided"}. Defaults to \code{TRUE}.}
}
\value{
A list with class "htest" containing the following components:
  \describe{ \item{statistic}{the value of the statistics} \item{p.value}{the
  p-values for the tests}}

A list with elements \describe{ \item{stat}{A vector of \code{m}
  Wilcoxon sum rank test statistics of association between \code{X} and
  \code{y}.} \item{stat0Mat}{An \code{m} x \code{B} matrix of \code{B}
  realizations of a \code{m}-dimensional vector of test statistics under the
  null hypothesis of no association between \code{X} and \code{y}.}}
}
\description{
Vectorized version of the binomial test
}
\examples{

alt <- c("two.sided", "less", "greater")[1]

p <- 100
n0 <- 60; n1 <- 40
mat0 <- matrix(rbinom(p*n0, size = 1, prob = 0.05), ncol = n0)
mat1 <- matrix(rbinom(p*n1, size = 1, prob = 0.02), ncol = n1)
mat <- cbind(mat0, mat1)
cls <- rep(c(0, 1), times = c(n0, n1))
fbt <- rowBinomialTests(mat, categ = cls, alternative = alt)
str(fbt)

# compare with ordinary binom.test:
pbt <- t(sapply(1:p, FUN=function(ii) {
  x1 <- mat[ii, cls==1]
  x0 <- mat[ii, cls==0]
  bt <- binom.test(sum(x1), length(x1), mean(x0), alternative = alt)
  c(statistic = bt[["statistic"]], p.value = bt[["p.value"]])
}))
all(abs(fbt$p.value-pbt[, "p.value"]) < 1e-10)  ## same results
all(abs(fbt$statistic-pbt[, "statistic.number of successes"]) < 1e-10)  ## same results

}
\seealso{
binom.test
}
\author{
Gilles Blanchard, Pierre Neuvial and Etienne Roquain
}

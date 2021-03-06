% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SimesThresholdFamily.R
\name{SimesThresholdFamily}
\alias{SimesThresholdFamily}
\title{SimesThresholdFamily}
\usage{
SimesThresholdFamily(m, kMax = m)
}
\arguments{
\item{m}{The number of hypotheses tested}

\item{kMax}{For simultaneous control of (\eqn{k}-FWER for all \eqn{k \le
k[max]}).}
}
\value{
A threshold function (on the scale of test statistics) based on the
classical family of thresholds introduced by Simes (1986):
\eqn{\alpha*k/m}. This family yields joint FWER control at level (at most)
\eqn{\alpha} if the test statistics are positively dependent (PRDS) under
H0.
}
\description{
Simes' threshold family
}
\examples{

sk <- SimesThresholdFamily(12)
thr <- sk(0.2)

}
\author{
Gilles Blanchard, Pierre Neuvial and Etienne Roquain
}

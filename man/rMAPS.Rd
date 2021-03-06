% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{rMAPS}
\alias{rMAPS}
\title{Sample rMAPS data}
\format{An integer matrix with 250 rows and 4642 columns. Each row
  corresponds to a genomic position relative to a splicing event, and each
  column corresponds to an exon. The entries of the matrix correspond to the
  number of matches of a particular DNA motif in the The samples are in two
  groups indicated by the column names of the matrix: 4550 controls ("0") and
  92 inclusion events ("1") corresponding to the status of the exon in a
  preliminary differential splicing analysis performed by rMATS.}
\usage{
rMAPS
}
\description{
Sample rMAPS data
}
\details{
rMAPS is a computational motif enrichment analysis tool for
  RNA-binding proteins using RNA-seq and CLIP-seq data. See
  http://rmaps.cecsresearch.org
}
\references{
Shen S., *et al.* (2014). rMATS: Robust and Flexible Detection of
  Differential Alternative Splicing from Replicate RNA-Seq Data. *PNAS*,
  111(51):E5593-601

Park JW, *et al.* (2016). rMAPS: RNA Map Analysis and Plotting
  Server for Alternative Exon Regulation. *Nucleic Acids Research*.
}
\keyword{datasets}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VDJ_extract_germline_MIXCR.R
\name{VDJ_germline}
\alias{VDJ_germline}
\title{Infer germline from the desired software/caller}
\usage{
VDJ_germline(VDJ, germlines.from, VDJ.only)
}
\arguments{
\item{VDJ}{VDJ dataframe obtained after calling VDJ_call_MIXCR or any other germline you want to use}

\item{germlines.from}{MIXCR or any other germline caller - default: MIXCR}

\item{VDJ.only}{boolean - if T, only Heavy Chain (VDJ) germline will be inferred}
}
\value{
VDJ with the updated germline
}
\description{
Function to infer the germline from the tree
}
\examples{
\donttest{
try({
VDJ_germline(VDJ, germlines.from='MIXCR',
VDJ.only=T)
})
}
}

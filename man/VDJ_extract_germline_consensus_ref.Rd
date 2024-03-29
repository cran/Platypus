% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VDJ_extract_germline_consensus_ref.R
\name{VDJ_extract_germline_consensus_ref}
\alias{VDJ_extract_germline_consensus_ref}
\title{Making the trimmed reference and concatenating fr1-fr4}
\usage{
VDJ_extract_germline_consensus_ref(
  VDJ,
  n_clones = NA,
  samples = NA,
  ref = TRUE,
  path_toData = "../Data/"
)
}
\arguments{
\item{VDJ}{VDJ or vgm[[1]] object, as obtained from the VDJ_GEX_matrix function in Platypus.}

\item{n_clones}{integer, denoting the top n clones to get the reference. If NA it is performed in all clones}

\item{samples}{list of sample names, with the same order as they were accessed to make the VGM}

\item{ref}{bool, denoting whether or not we trim the reference of the antibodies.}

\item{path_toData}{str, denoting the folder containing the VDJ folder with VDJ information per sample}
}
\value{
$vdj: VDJ containing the VDJ/VJ_ref.nt/aa columns if ref = TRUE and the full_VDJ, full_VJ columns with the fr1-fr4. $clones: clone_ids for which a reference was made.
}
\description{
Function that takes the VDJ and the fr1-fr4 sequence per antibody
Based on the ref argument, if TRUE it also returns the returns in the VDJ/VJ_ref.nt/aa the trimmed reference based
on the alignement with the consensus.
}
\examples{
\donttest{
try({
samples = c('LCMV', 'TNFR')
vgm = read("VGM.RData")
n_clones = 20
result = VDJ_extract_germline_consensus_ref(vgm$VDJ, n_clones,
samples, ref = TRUE,
path_toData="../Data/")
VDJ = result[1]$vdj
clone_counts = result[2]$clones
})
}

}

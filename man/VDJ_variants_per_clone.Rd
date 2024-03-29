% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VDJ_variants_per_clone.R
\name{VDJ_variants_per_clone}
\alias{VDJ_variants_per_clone}
\title{Wrapper for variant analysis by clone}
\usage{
VDJ_variants_per_clone(
  VDJ,
  variants.of,
  clonotypes.col,
  stringDist.method,
  split.by,
  platypus.version
)
}
\arguments{
\item{VDJ}{VDJ output of the VDJ_GEX_matrix (VDJ_GEX_matrix.output[[1]]). VDJ matrix supplemented with with MIXCR information is also valid}

\item{variants.of}{Character vector. Defaults to c("VDJ_cdr3s_aa", "VJ_cdr3s_aa"). Column name(s) of VDJ to examine variants of. If more than one name is given, these columns will be pasted together. The default will therefore return statistics on the number of variants of VDJ and VJ cdr3s in every clone}

\item{clonotypes.col}{Column name of the VDJ column containing clonotype information. Defaults to "clonotype_id_10x". This is useful if alternative clonotyping strategies have been used and are stored in other columns}

\item{stringDist.method}{Character. Passed to Biostrings::strinDist. Method to calculate distance between variants of a clone. Defaults to "levenshtein". Other options are "hamming", "quality". If "hamming" variants of a clone will be shortened from the end to the shortest variant to make all input sequences the same length.}

\item{split.by}{Character. Defaults to "sample_id". Column name of VDJ to split the analysis by. This is necessary, if clonotyping was done on a per sample level (e.g. "clonotype1" in sample 1 is not the same sequence as "clonotype1" in sample 2). If clonotyping was done across samples and no splitting is necessary input "none"}

\item{platypus.version}{Character. Only "v3" available.}
}
\value{
Returns a list of dataframes. Each dataframe contains the statistics of one split.by element (by default: one sample)
}
\description{
Returns statistics and plots to examine diversity of any sequence or metadata item within clones on a by sample level or global level
}
\examples{
variants_per_clone <- VDJ_variants_per_clone(VDJ = Platypus::small_vgm[[1]]
,variants.of = c("VDJ_cdr3s_aa", "VJ_cdr3s_aa"),
stringDist.method = "levenshtein", split.by = "sample_id")

}

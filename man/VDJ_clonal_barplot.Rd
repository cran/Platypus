% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VDJ_clonal_barplot.R
\name{VDJ_clonal_barplot}
\alias{VDJ_clonal_barplot}
\title{Function to create stacked barplots to visualize clonal expansion per repertoire directly from a VDJ matrix (either from the minimal_VDJ() or VDJ_GEX_matrix())}
\usage{
VDJ_clonal_barplot(
  VDJ,
  counts.to.use,
  group.by,
  expanded.colors,
  non.expanded.color
)
}
\arguments{
\item{VDJ}{VDJ matrix (either from the minimal_VDJ() or VDJ_GEX_matrix()}

\item{counts.to.use}{The column name in the VDJ matrix of the clonotypes you want to use. Defaults to "clonotype_id".}

\item{group.by}{The column name in the VDJ matrix on which you want to seperate the repertoire plots. If the entire VDJ matrix is one repertoire, this argument should be "none" or empty.}

\item{expanded.colors}{Character vector. Colors to use for expanded clones. Should be more than 3 for better visibility. Defaults to a "darkorchid3"-based palette.}

\item{non.expanded.color}{Character. Color to use for non expanded clones. Defaults to "black"}
}
\value{
Returns a list with a ggplot for each group.by element.
}
\description{
Function to create stacked barplots to visualize clonal expansion per repertoire directly from a VDJ matrix (either from the minimal_VDJ() or VDJ_GEX_matrix()).
}
\examples{
out <- VDJ_clonal_barplot(Platypus::small_vgm[[1]],
counts.to.use = "clonotype_id_10x",group.by = "sample_id")

}

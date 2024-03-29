% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VDJ_clonal_donut.R
\name{VDJ_clonal_donut}
\alias{VDJ_clonal_donut}
\title{Circular VDJ expansion plots}
\usage{
VDJ_clonal_donut(
  VDJ,
  counts.to.use,
  label.size,
  not.expanded.label.vjust,
  not.expanded.label.hjust,
  total.label.vjust,
  total.label.hjust,
  expanded.colors,
  non.expanded.color
)
}
\arguments{
\item{VDJ}{VDJ dataframe generated using the VDJ_GEX_matrix function (VDJ_GEX_matrix.output[[1]]). Plots will be made by sample and using the clonal frequencies specified by counts.to.use}

\item{counts.to.use}{How to count clonotypes and cells. A column name of the VDJ matrix containing clonotype IDs. This defaults to "clonotype_id_10x", which reflects clonotypes by Cellranger in an unaltered VGM. To use counts from the VDJ_clonotype_v3 function set this parameter to the relevant column e.g. "clonotype_id_cdr.aa" or   "global_clonotype_id_cdr.aa" are two examples.}

\item{label.size}{Size of text labels. All parameters below are purely for graphical purposes and optional. If necessary changes should be made in small (0.1) increments. ! It is recommended to optimize these ONLY once a format for saving the plot is set.}

\item{not.expanded.label.vjust}{Numeric. Regulates the vertical position of the label for non expanded cells}

\item{not.expanded.label.hjust}{Numeric. Regulates the horizontal position of the label for non expanded cells}

\item{total.label.vjust}{Numeric. Regulates the vertical position of the center label}

\item{total.label.hjust}{Numeric. Regulates the horizontal position of the center label}

\item{expanded.colors}{Character vector. Colors to use for expanded clones. Should be more than 3 for better visibility. Defaults to a "darkorchid3"-based palette.}

\item{non.expanded.color}{Character. Color to use for non expanded clones. Defaults to "black"}
}
\value{
Returns a list of circular plots showing proportions of expanded clones and non-expanded clones. One plot is generated for each sample in the sample_id column
}
\description{
Generate circular plots of clonal expansion per repertoire directly from the VDJ matrix of the VDJ_GEX_matrix function
}
\examples{
VDJ_clonal_donut(VDJ = Platypus::small_vgm[[1]])

}

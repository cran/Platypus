% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VDJ_build.R
\name{VDJ_build}
\alias{VDJ_build}
\title{Minimal Version of the VDJ Building Part from VDJ_GEX_matrix() Function}
\usage{
VDJ_build(
  VDJ.directory,
  VDJ.sample.list,
  remove.divergent.cells,
  complete.cells.only,
  trim.germlines,
  gap.opening.cost,
  parallel,
  num.cores
)
}
\arguments{
\item{VDJ.directory}{A string specifying the path to the parent directory containing the output folders (one folder for each sample) of Cell Ranger. This pipeline assumes that the output file names have not been changed from the default 10x settings in the `/outs/` folder. This is compatible with B and T cell repertoires. The following 5 files are necessary within this folder: 
\describe{
  \item{`filtered_contig_annotations.csv`}{Contains the filtered contig annotations.}
  \item{`filtered_contig.fasta`}{Contains the filtered contig sequences in FASTA format.}
  \item{`consensus_annotations.csv`}{Contains the consensus annotations.}
  \item{`consensus.fasta`}{Contains the consensus sequences in FASTA format.}
  \item{`concat_ref.fasta`}{Contains concatenated reference sequences.}
}}

\item{VDJ.sample.list}{A list specifying the paths to the output folders (one folder for each sample) of Cell Ranger. This pipeline assumes that the output file names have not been changed from the default 10x settings in the `/outs/` folder and requires the same 5 files listed above.}

\item{remove.divergent.cells}{A logical value (`TRUE`/`FALSE`). If `TRUE`, cells with more than one VDJ transcript or more than one VJ transcript will be excluded. This could be due to multiple cells being trapped in one droplet or light chain dual expression (concerns ~2-5 percent of B cells, see DOI:10.1084/jem.181.3.1245). Defaults to `FALSE`.}

\item{complete.cells.only}{A logical value (`TRUE`/`FALSE`). If `TRUE`, only cells with both a VDJ transcript and a VJ transcript are included in the VDJ dataframe. Keeping only cells with 1 VDJ and 1 VJ transcript could be preferable for downstream analysis. Defaults to `FALSE`.}

\item{trim.germlines}{A logical value (`TRUE`/`FALSE`). If `TRUE`, the raw germline sequences of each clone will be trimmed using the consensus sequences of that clone as reference sequences (using `Biostrings::pairwiseAlignment` with the option "global-local" and a gap opening cost specified by `gap.opening.cost`). Defaults to `FALSE`.}

\item{gap.opening.cost}{A numeric value representing the cost for opening a gap in `Biostrings::pairwiseAlignment` when aligning and trimming germline sequences. Defaults to 10.}

\item{parallel}{A logical value (`TRUE`/`FALSE`). If `TRUE`, the per-sample VDJ building is executed in parallel (parallelized across samples). Defaults to `FALSE`.}

\item{num.cores}{An integer specifying the number of cores to be used when `parallel = TRUE`. Defaults to all available cores minus 1 or the number of sample folders in `VDJ.directory` (whichever is smaller).}
}
\value{
A dataframe representing the VDJ / VGM[[1]] object. Each row in this dataframe represents one cell or one unique cell barcode.
}
\description{
This function imports Cell Ranger output into an R dataframe for downstream analyses. It is a minimal version of the VDJ building part from the `VDJ_GEX_matrix()` function of the Platypus package, adapted for Cell Ranger v7 and older versions. Seurat objects can be integrated by matching barcodes from the Seurat object's metadata with the barcodes in the `barcode` column of the VDJ dataframe.
}
\details{
The function extracts and processes VDJ data from Cell Ranger output folders, making it suitable for integration with downstream analysis workflows such as Seurat. It can handle both T and B cell repertoires and is optimized for Cell Ranger v7.
}
\examples{
\donttest{
try({
  VDJ <- VDJ_build(
    VDJ.directory = "path/to/VDJ_directory",
    remove.divergent.cells = TRUE,
    complete.cells.only = TRUE,
    trim.germlines = TRUE
  )
})
}
}

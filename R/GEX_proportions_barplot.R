#' Plots proportions of a group of cells within a secondary group of cells. E.g. The proportions of samples in seurat clusters, or the proportions of samples in defined cell subtypes
#' @param GEX GEX Seurat object generated with VDJ_GEX_matrix (VDJ_GEX_matrix.output[[2]])
#' @param source.group Character. A column name of the GEX@meta.data with the group of which proportions should be plotted
#' @param target.group Character. A column name of the GEX@meta.data with the group to calculate proportions within. If unsure, see examples for clarification
#' @param stacked.plot Boolean. Defaults to FALSE. Whether to return a stacked barplot, with the y axis representing the \% of cells of the target group. If set to FALSE a normal barplot (position = "dodge") will be returned with the y axis representing the \% of cells of the source group
#' @return Returns a ggplot barplot showing cell proportions by source and target group.
#' @export
#' @examples
#' \donttest{
#' try({
#'GEX_proportions_barplot(GEX = Platypus::small_vgm[[2]], source.group = "sample_id"
#', target.group = "seurat_clusters",stacked.plot = FALSE)
#'GEX_proportions_barplot(GEX = Platypus::small_vgm[[2]],
#' source.group = "seurat_clusters", target.group = "sample_id"
#' ,stacked.plot = TRUE)
#' })
#'}

GEX_proportions_barplot <- function(GEX,
                                    source.group,
                                    target.group,
                                    stacked.plot
                                    ){


  value <- NULL
  target <- NULL

  if(missing(verbose)) verbose <- FALSE
  platypus.version <- "does not matter"
  if(missing(source.group)) source.group <- "sample_id"
  if(missing(target.group)) target.group <- "seurat_clusters"
  if(missing(stacked.plot)) stacked.plot <- FALSE

  unique_samples <- unique(GEX@meta.data[,source.group])
  unique_clusters <- unique(GEX@meta.data[,target.group])

  cells_per_cluster_per_sample <- list()
  for(i in 1:length(unique_samples)){
    cells_per_cluster_per_sample[[i]] <- list()
    for(j in 1:length(unique_clusters)){

      if(stacked.plot == FALSE){ #if normal barplot: get % of source group
        cells_per_cluster_per_sample[[i]][[j]] <- length(which(GEX@meta.data[,source.group]==unique_samples[i] & GEX@meta.data[,target.group]==unique_clusters[j]))/length(which(GEX@meta.data[,source.group]==unique_samples[i])) * 100
      } else { #if stacked barplot: get % of target group
        cells_per_cluster_per_sample[[i]][[j]] <- length(which(GEX@meta.data[,source.group]==unique_samples[i] & GEX@meta.data[,target.group]==unique_clusters[j]))/length(which(GEX@meta.data[,target.group]==unique_clusters[j])) * 100
      }
    }
  }
  melting <- as.data.frame(reshape2::melt(cells_per_cluster_per_sample))

  melting$source.group <- "Unkown"
  melting$target.group <- "Unkown"

  melting$source.group <- as.character(unique_samples[melting$L1])
  melting$target.group <- as.character(unique_clusters[melting$L2])
  colnames(melting) <- c("value", "L2", "Sample", "source", "target")

  if("factor" %in% class(GEX@meta.data[,source.group])){
    if(verbose) message("Ordering based on existing source group factor levels")
  melting$source <- ordered(as.factor(melting$source), levels = levels(GEX@meta.data[,source.group]))
  } else {

    if(verbose) message("Reordering source group, as original column did not contain factor levels")
    melting$source <- ordered(as.factor(melting$source), levels = unique(GEX@meta.data[,source.group]))
  }
  if("factor" %in% class(GEX@meta.data[,target.group])){
    if(verbose) message("Ordering based on existing target group factor levels")
  melting$target <- ordered(as.factor(melting$target), levels = levels(GEX@meta.data[,target.group]))} else {
    if(verbose) message("Reordering target group, as original column did not contain factor levels")
    melting$target <- ordered(as.factor(melting$target), levels = unique(GEX@meta.data[,target.group]))}

  if(stacked.plot == FALSE){
    if(verbose) message("Returning standard barplot with y axis = % of cells of source group")
  output.plot <- ggplot2::ggplot(melting, ggplot2::aes(fill = source, y=value, x=target)) + ggplot2::geom_bar(stat="identity", width=0.6, color="black",position = "dodge") + ggplot2::theme_bw() + ggplot2::theme_classic() + ggplot2::theme(plot.margin = ggplot2::margin(5, 0, 0, 0, "mm")) + ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) + ggplot2::scale_y_continuous(expand = c(0,0)) + ggplot2::ylab(paste0("% of cells of ", source.group)) + ggplot2::xlab(paste0(target.group))
  }else{
    if(verbose) message("Returning stacked barplot with y axis = % of cells of target group")
    output.plot <- ggplot2::ggplot(melting, ggplot2::aes(fill = source, y=value, x=target)) + ggplot2::geom_bar(stat="identity", width=0.6, color="black", position = "stack") + ggplot2::theme_bw() + ggplot2::theme_classic() + ggplot2::theme(plot.margin = ggplot2::margin(5, 0, 0, 0, "mm")) + ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) + ggplot2::scale_y_continuous(expand = c(0,0)) + ggplot2::ylab(paste0("% of cells of ", source.group)) + ggplot2::xlab(paste0(target.group))
  }
  return(output.plot)
}

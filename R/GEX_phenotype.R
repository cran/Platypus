#' Assignment of cells to phenotypes based on selected markers
#'
#' @description Adds a column to a VGM[[2]] Seurat object containing cell phenotype assignments. Defaults for T and B cells are available. Marker sets are customizable as below
#' @param seurat.object A single seurat object / VDJ_GEX_matrix.output[[2]] object
#' @param cell.state.names Character vector containing the cell state labels defined by the markers in cell.state.markers parameter. Example is c("NaiveCd4","MemoryCd4").
#' @param cell.state.markers Character vector containing the gene names for each state. ; is used to use multiple markers within a single gene state. Different vector elements correspond to different states. Order must match cell.state.names containing the c("CD4+;CD44-","CD4+;IL7R+;CD44+").
#' @param default Default is TRUE - will use predefined gene sets and cell states.
#' @return Returns the input Seurat object with an additional column
#' @export
#' @examples
#' vgm.phenotyped <- GEX_phenotype(seurat.object = Platypus::small_vgm[[2]]
#' , default = TRUE)
#'

GEX_phenotype <- function(seurat.object, cell.state.names, cell.state.markers, default){

  if(missing(default)) default<- TRUE
  Cap<-function(x){
    temp<-c()
    for (i in 1:length(x)){
      s <- strsplit(x, ";")[[i]]
      temp[i]<-paste(toupper(substring(s, 1,1)), tolower(substring(s, 2)), sep="", collapse=";")
    }
    return(temp)
  }

  is.hum<-any(useful::find.case(rownames(seurat.object),case="upper"))

  if(missing(cell.state.markers)&default==TRUE){
    cell.state.markers<-c("CD4+;CD44-",
                          "CD4+;IL7R+;CD44+",
                          "CD4+;CD44+;IL7R-;IFNG+",
                          "CD8A+;TCF7+;CD44-",
                          "CD8A+;CX3CR1+;IL7R-",
                          "CD8A+;IL7R+;CD44+",
                          "PDCD1+;CD8A+",
                          "CD19+;CD27-;CD38-",
                          "FAS+;CD19+",
                          "SDC1+",
                          "CD38+;FAS-")
  }
  if(missing(cell.state.names)&default==TRUE){
    cell.state.names<-c("NaiveCd4",
                        "MemoryCd4",
                        "ActivatedCd4",
                        "NaiveCd8",
                        "EffectorCd8",
                        "MemoryCd8",
                        "ExhaustedCd8",
                        "NaiveBcell",
                        "GerminalcenterBcell",
                        "Plasmacell",
                        "MemoryBcell")
  }

  if(is.hum==FALSE&&default==TRUE){
    if(is.hum==FALSE){
      cell.state.markers<-Cap(cell.state.markers)
    }
    if(is.hum==TRUE&&default==TRUE){
      cell.state.markers <- toupper(cell.state.markers)
    }
  }
  #parse cell state markers

  cell.state.markers<-gsub(pattern = ";", replacement ="&", cell.state.markers)
  cell.state.markers<-gsub(pattern = "\\+", replacement =">0", cell.state.markers)
  cell.state.markers<-gsub(pattern = "-", replacement ="==0", cell.state.markers)

  #execute cmd
  seurat.object[["previous.ident"]] <- Seurat::Idents(object = seurat.object)#(clusters ID)
  Seurat::Idents(seurat.object)<-"Unclassified"
  cmd<-c()
  for(i in 1:length(cell.state.names)){

    cmd[i]<-paste0(cell.state.names[i],"<-Seurat::WhichCells(seurat.object, slot = 'counts', expression =", cell.state.markers[i],")")
    is.exist<-tryCatch(expr=length(eval(parse(text=cmd[i]))), error = function(x){
      x<-FALSE
      return(x)})
    if(is.exist!=FALSE){
      Seurat::Idents(object = seurat.object, cells = eval(parse(text=cell.state.names[i])) ) <- cell.state.names[i]
    }
  }
  seurat.object[["cell.state"]] <- Seurat::Idents(object = seurat.object)
  Seurat::Idents(object = seurat.object) <- unname(unlist(seurat.object[["previous.ident"]]))

  return(seurat.object)
}

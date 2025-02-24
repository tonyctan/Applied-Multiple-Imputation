compare.percent.count <- function(orig,imp,counts){
  nam=names(orig[colSums(is.na(orig))>0])
  nam = nam[nam %in% counts]
  output <- vector(length(nam), mode="list")
  names(output)<-nam
  for (i in 1:length(nam)){
    data <- mice::complete(imp,"long")
    ry= is.na(orig[,nam[i]])
    ry[ry==TRUE]<-"imputed"
    ry[ry==FALSE]<-"observed"
    data <- cbind(data,ry)
    colnames(data)[length(colnames(data))]<-paste0("R.",nam[i])
    tab <- table(data[,nam[i]],data[,paste0("R.",nam[i])])
    
    
    output[[i]]<- rbind("imputed"=round(tab[,1]/sum(tab[,1])*100,2),
                        "observed"=round(tab[,2]/sum(tab[,2])*100,2))
    
  }
  return(output)
}
library(iFinDR)
library(RJSONIO)
ret = THS_iFinDLogin("hxjy106","666888")





filepath="C:/Users/LENOVO/Desktop/Pro4/initial/0..txt"
file.create(filepath)
  
  for (j in 2009:2019){
  start=paste0(j,"-01-01")
  end=paste0(j,"-12-31")
  ans = THS_DateSerial('000001.SH,399001.SZ,DJI.GI,HSI.GI,IXIC.GI,NDX.GI,NYA.GI,SPX.GI,XAX.GI','ths_index_short_name_index;ths_pe_ttm_index;ths_pb_index',';100,100;100,100','Days:Tradedays,Fill:Previous,Interval:D,block:history',start,end)
    
  for (i in 1:9){
  date = ans$tables[[i]]$time
  name = ans$tables[[i]]$table$ths_index_short_name_index
    if (typeof(ans$tables[[i]]$table$ths_pe_ttm_index)=="list") pe_ttm = unlist(ans$tables[[i]]$table$ths_pe_ttm_index, use.names=FALSE) else pe_ttm = ans$tables[[i]]$table$ths_pe_ttm_index
    if (typeof(ans$tables[[i]]$table$ths_pb_index)=="list") pb = unlist(ans$tables[[i]]$table$ths_pb_index, use.names=FALSE) else pb = ans$tables[[i]]$table$ths_pb_index
  text<-data.frame(date,name,pe_ttm,pb)  
    write.table(text,file = filepath,row.names = F, col.names = F,quote = F,sep="\t",append = T,fileEncoding="UTF-8")
  }
  }
  

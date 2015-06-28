if(!require(RMySQL)){install.packages("RMySQL")}
library(RMySQL)

mydb = dbConnect(MySQL(), user=config$db$user, password=config$db$password, dbname=config$db$database, host=config$db$host)
setwd(config$ftp$downloadDir)

data.tables<-list.files(pattern="\\.csv",recursive=T)

df.options<-read.csv(data.tables[1],stringsAsFactors = F)[2:20]
colnames(df.options)<-c("underlying","underlying_last_price","exchange","option_symbol","option_type","expiration_date","quote_date","strike_price","last_price","bid_price","ask_price","volume","open_interest","implied_volatility","delta","gamma","theta","vega","data_load_date")
df.options[df.options$option_type=='call',]$option_type='C'
df.options[df.options$option_type=='put',]$option_type='P'

df.stats<-read.csv(data.tables[2],stringsAsFactors = F)
colnames(df.stats)<-c("underlying","quote_date","call_iv","put_iv","mean_iv","call_vol","call_open_interest","put_open_interest","data_load_date")

df.stocks<-read.csv(data.tables[3],stringsAsFactors = F)
df.stocks<-cbind(df.stocks,rep(NA,nrow(df.stocks)))
colnames(df.stocks)<-c("symbol","quote_date","open","high","low","close","volume","data_load_date")

#transform
df.options<-transform(df.options,expiration_date=as.character(as.Date(df.options$expiration_date,"%m/%d/%Y")),quote_date=as.character(as.Date(df.options$quote_date,"%m/%d/%Y")),data_load_date=as.character(Sys.Date()))
df.stats<-transform(df.stats,quote_date=paste(substr(df.stats$quote_date,0,4),substr(df.stats$quote_date,5,6),substr(df.stats$quote_date,7,8),sep='-'),data_load_date=as.character(Sys.Date()))
df.stocks<-transform(df.stocks,quote_date=as.character(as.Date(df.stocks$quote_date,"%m/%d/%Y")),data_load_date=as.character(Sys.Date()))



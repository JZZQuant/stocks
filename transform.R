if(!require(RMySQL)){install.packages("RMySQL")}
library(RMySQL)

mydb = dbConnect(MySQL(), user=config$db$user, password=config$db$password, dbname=config$db$database, host=config$db$host)
setwd(config$ftp$downloadDir)

data.tables<-list.files(pattern="\\.csv",recursive=T)

df<-read.csv(data.tables[1])
colnames(df)<-c("underlying","underlying_last_price","exchange","option_symbol","option_type","expiration_date","quote_date","strike_price","last_price","bid_price","ask_price","volume","open_interest","implied_volatility","delta","gamma","theta","vega","data_load_date")


df<-read.csv(data.tables[2])
colnames(df)<-c("underlying","quote_date","call_iv","put_iv","mean_iv","call_vol","call_open_interest","put_open_interest","data_load_date")

df<-read.csv(data.tables[3])
colnames(df)<-c("symbol","quote_date","open","high","low","close","volume","data_load_date")


if(!require(RMySQL)){install.packages("RMySQL")}
library(RMySQL)
if(!require(yaml)){install.packages("yaml")}
library(yaml)

config = yaml.load_file("config.yml")
mydb = dbConnect(MySQL(), user=config$db$user, password=config$db$password, dbname=config$db$database, host=config$db$host)
if(length(mydb) <1){stop("Database connection could not be made")}
setwd(config$ftp$downloadDir)

#https://github.com/rstats-db/RMySQL/blob/master/R/table.R#L104 bulk inserts all records instead of inserting in a loop
# so we just need to set the auto increment to 2 (this has to be done before executing the script)

# write data to mysql table
batchwritetable(mydb,'options_eod_table',df.options,1000)
batchwritetable(mydb,'optionstats_eod_table',df.stats,1000)
batchwritetable(mydb,'stockquotes_eod_table',df.stocks,1000)

dbDisconnect(mydb)

setwd('..')


batchwritetable<-function(db,table,df,size)
{
  df.batches<-split(dfrm, (0:nrow(df) %/% size))
  apply(df.batches,1,function(batch) 
    {  
  x<-dbWriteTable(db, name=table,row.names = FALSE, value=batch,overwrite = FALSE, append = TRUE,header = F)
  if(!x){stop("table Data could not be written correctly")}
    } 
       )
}
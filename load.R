if(!require(RMySQL)){install.packages("RMySQL")}
library(RMySQL)
if(!require(yaml)){install.packages("yaml")}
library(yaml)

config = yaml.load_file("config.yml")
mydb = dbConnect(MySQL(), user=config$db$user, password=config$db$password, dbname=config$db$database, host=config$db$host)
if(length(mydb) <1){stop("Database connection could not be made")}
setwd(config$ftp$downloadDir)

# write data to mysql table
x<-dbWriteTable(mydb, name='options_eod_table',row.names = FALSE, value=df.options,overwrite = FALSE, append = TRUE,header = F)
if(!x){stop("options_eod_table Data could not be written correctly")}
y<-dbWriteTable(mydb, name='optionstats_eod_table',row.names = FALSE, value=df.stats,overwrite = FALSE, append = TRUE,header = F)
if(!y){stop("optionstats_eod_table Data could not be written correctly")}
z<-dbWriteTable(mydb, name='stockquotes_eod_table',row.names = FALSE, value=df.stocks,overwrite = FALSE, append = TRUE,header = F)
if(!z){stop("stockquotes_eod_table Data could not be written correctly")}

dbDisconnect(mydb)

setwd('..')

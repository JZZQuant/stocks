if(!require(RMySQL)){install.packages("RMySQL")}
library(RMySQL)
mydb = dbConnect(MySQL(), user=config$db$user, password=config$db$password, dbname=config$db$database, host=config$db$host)
setwd(config$ftp$downloadDir)

dbWriteTable(mydb, name='options_eod_table',row.names = FALSE, value=df.options,overwrite = FALSE, append = TRUE,header = F)
dbWriteTable(mydb, name='optionstats_eod_table',row.names = FALSE, value=df.stats,overwrite = FALSE, append = TRUE,header = F)
dbWriteTable(mydb, name='stockquotes_eod_table',row.names = FALSE, value=df.stocks,overwrite = FALSE, append = TRUE,header = F)
dbDisconnect(mydb)

setwd('..')

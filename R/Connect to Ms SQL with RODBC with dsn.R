# If the DBMS user and password are needed and not stored in the DSN, they can be supplied
# by e.g.
# ch <- odbcConnect("some dsn", uid = "user", pwd = "****")

# TESTED for USAID  

rm(list = ls())
library(RODBC)
library (sqldf)

require(RODBC)

ch <- odbcConnect("Mozart", uid = "ciceronhantumbo", pwd = "MozArt*#7")
sqlTables(ch)

df_paciente <- sqlFetch(ch, "t_paciente")
head(df_paciente)

df_paciente_15 <- sqldf("select  * from df_paciente where idade < 16 ")



close(ch)
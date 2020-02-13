######################################################################################################
####################READS ACCESS DATABASE TABLES AND exports To tXt FLAT FILES########################
######################################################################################################
 

setwd("C:/Users/cnhantumbo/Documents/MOZART/Mozart_EchoFY20Q1")
#clear R
rm(list = ls())
cat("\014")
#Load ODBC package for MS Access Files
#make sure Rstudio is in 32-bit by going to tools->global options
library(RODBC)
library(dplyr)
#require(tcltk)



#parent folder should be where every database needed is stored

Parent.Folder <- "C:/Users/cnhantumbo/Documents/MOZART/Mozart_EchoFY20Q1/all"

#creation of list of databases/inputs
list_filenames <- list.files(Parent.Folder, full.names = TRUE, recursive = FALSE)
acc_files <- list_filenames[grep(".mdb", list_filenames)]

#run loop of selecting hdd table from each DB, converting the columns to factors
hdd_output <- lapply(acc_files, 
                 function(file) {
                   channel <- odbcConnectAccess(file)                       
                   data <- sqlQuery(channel, "select * from t_hdd")
                   close(channel)
                   return(data) 
                 })
hdd_output <- lapply(hdd_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_hdd <- rbind_all(hdd_output)
write.table(t_hdd, file = "t_hdd.txt", sep = "\t",row.names = TRUE)
rm(t_hdd)



#run loop of selecting patient table from each DB, converting the columns to factors
paciente_output <- lapply(acc_files, 
                  function(file) {
                    channel <- odbcConnectAccess(file)                       
                    data <- sqlQuery(channel, "select * from t_paciente")
                    close(channel)
                    return(data) 
                  })
paciente_output <- lapply(paciente_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_paciente <- rbind_all(paciente_output)
write.table(t_paciente, file = "t_paciente.txt", sep = "\t",row.names = TRUE)
rm(t_paciente)


#run loop of selecting adulto table from each DB, converting the columns to factors
adulto_output <- lapply(acc_files, 
                         function(file) {
                           channel <- odbcConnectAccess(file)                       
                           data <- sqlQuery(channel, "select * from t_adulto")
                           close(channel)
                           return(data) 
                         })
adulto_output <- lapply(adulto_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_adulto <- rbind_all(adulto_output)
write.table(t_adulto, file = "t_adulto.txt", sep = "\t",row.names = TRUE)
rm(t_adulto)

#run loop of selecting crianca table from each DB, converting the columns to factors
crianca_output <- lapply(acc_files, 
                        function(file) {
                          channel <- odbcConnectAccess(file)                       
                          data <- sqlQuery(channel, "select * from t_crianca")
                          close(channel)
                          return(data) 
                        })
crianca_output <- lapply(crianca_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_crianca <- rbind_all(crianca_output)
write.table(t_crianca, file = "t_crianca.txt", sep = "\t",row.names = TRUE)
rm(t_crianca)

#run loop of selecting gaac_actividades table from each DB, converting the columns to factors
gaac_actividades_output <- lapply(acc_files, 
                         function(file) {
                           channel <- odbcConnectAccess(file)                       
                           data <- sqlQuery(channel, "select * from t_gaac_actividades")
                           close(channel)
                           return(data) 
                         })
gaac_actividades_output <- lapply(gaac_actividades_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_gaac_actividades <- rbind_all(gaac_actividades_output)
write.table(t_gaac_actividades, file = "t_gaac_actividades.txt", sep = "\t",row.names = TRUE)
rm(t_gaac_actividades)

#run loop of selecting gaac table from each DB, converting the columns to factors
gaac_output <- lapply(acc_files, 
                                 function(file) {
                                   channel <- odbcConnectAccess(file)                       
                                   data <- sqlQuery(channel, "select * from t_gaac")
                                   close(channel)
                                   return(data) 
                                 })
gaac_output <- lapply(gaac_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_gaac <- rbind_all(gaac_output)
write.table(t_gaac, file = "t_gaac.txt", sep = "\t",row.names = TRUE)
rm(t_gaac)

#run loop of selecting observacaopaciente table from each DB, converting the columns to factors
observacaopaciente_output <- lapply(acc_files, 
                      function(file) {
                        channel <- odbcConnectAccess(file)                       
                        data <- sqlQuery(channel, "select * from t_observacaopaciente")
                        close(channel)
                        return(data) 
                      })
observacaopaciente_output <- lapply(observacaopaciente_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_observacaopaciente <- rbind_all(observacaopaciente_output)
write.table(t_observacaopaciente, file = "t_observacaopaciente.txt", sep = "\t",row.names = TRUE)
rm(t_observacaopaciente)

#run loop of selecting resultadoslaboratorio table from each DB, converting the columns to factors
resultadoslaboratorio_output <- lapply(acc_files, 
                                    function(file) {
                                      channel <- odbcConnectAccess(file)                       
                                      data <- sqlQuery(channel, "select * from t_resultadoslaboratorio")
                                      close(channel)
                                      return(data) 
                                    })
resultadoslaboratorio_output <- lapply(resultadoslaboratorio_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_resultadoslaboratorio <- rbind_all(resultadoslaboratorio_output)
write.table(t_resultadoslaboratorio, file = "t_resultadoslaboratorio.txt", sep = "\t",row.names = TRUE)
rm(t_resultadoslaboratorio)

#run loop of selecting seguimento table from each DB, converting the columns to factors
seguimento_output <- lapply(acc_files, 
                                       function(file) {
                                         channel <- odbcConnectAccess(file)                       
                                         data <- sqlQuery(channel, "select * from t_seguimento")
                                         close(channel)
                                         return(data) 
                                       })
seguimento_output <- lapply(seguimento_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_seguimento <- rbind_all(seguimento_output)
write.table(t_seguimento, file = "t_seguimento.txt", sep = "\t",row.names = TRUE)
rm(t_seguimento)

#run loop of selecting tarv table from each DB, converting the columns to factors
tarv_output <- lapply(acc_files, 
                            function(file) {
                              channel <- odbcConnectAccess(file)                       
                              data <- sqlQuery(channel, "select * from t_tarv")
                              close(channel)
                              return(data) 
                            })
tarv_output <- lapply(tarv_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_tarv <- rbind_all(tarv_output)
write.table(t_tarv, file = "t_tarv.txt", sep = "\t",row.names = TRUE)
rm(t_tarv)



#run loop of selecting tratamentoseguimento table from each DB, converting the columns to factors
tratamentoseguimento_output <- lapply(acc_files, 
                      function(file) {
                        channel <- odbcConnectAccess(file)                       
                        data <- sqlQuery(channel, "select * from t_tratamentoseguimento")
                        close(channel)
                        return(data) 
                      })
tratamentoseguimento_output <- lapply(tratamentoseguimento_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_tratamentoseguimento <- rbind_all(tratamentoseguimento_output)
write.table(t_tratamentoseguimento, file = "t_tratamentoseguimento.txt", sep = "\t",row.names = TRUE)
rm(t_tratamentoseguimento)


#run loop of selecting tratamentoTB table from each DB, converting the columns to factors
tratamentoTB_output <- lapply(acc_files, 
                                      function(file) {
                                        channel <- odbcConnectAccess(file)                       
                                        data <- sqlQuery(channel, "select * from t_tratamentoTB")
                                        close(channel)
                                        return(data) 
                                      })
tratamentoTB_output <- lapply(tratamentoTB_output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
t_tratamentoTB <- rbind_all(tratamentoTB_output)

write.table(t_tratamentoTB, file = "t_tratamentoTB.txt", sep = "\t",row.names = TRUE)
rm(t_tratamentoTB)

#msgBox <- tkmessageBox(title = "INFORMATION",
#                       message = "Finnish", icon = "info", type = "ok")










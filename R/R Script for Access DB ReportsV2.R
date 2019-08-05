######################################################################################################
###################MOZART ACCESS DB SOP DATA CHECKS###################################################
######################################################################################################
#REMEMBER TO RUN SCRIPT SEPARATELY BY PARTNER, POPULATE COUNTS, THEN RUN FOR NEXT PARTNER & REPEAT####
######################################################################################################
######################################################################################################
######################################################################################################
#################Code Updated Jul 26, 2019############################################################
######################################################################################################
############CLEAR ENVIRONMENT BETWEEN PARTNER RUNS####################################################
######################################################################################################
#clear R
rm(list = ls())
#Load ODBC package for MS Access Files
#make sure Rstudio is in 32-bit by going to tools->global options
library(RODBC)
library(dplyr)


#parent folder should be where every database needed is stored
#Parent.Folder <- "E:/Mozart/CDCQ3_2019/EGPAF_Q3"
#Parent.Folder <- "C:/Users/cnhantumbo/Documents/MOZART/MOZART_FY19Q3/all"
Parent.Folder <- "C:/Users/cnhantumbo/Documents/MOZART/MOZART_FY19Q2/all_FY19Q2"

#creation of list of databases/inputs
list_filenames <- list.files(Parent.Folder, full.names = TRUE, recursive = FALSE)
acc_files <- list_filenames[grep(".mdb", list_filenames)]


#run loop of selecting hdd table from each DB, converting the columns to factors
output <- lapply(acc_files, 
                 function(file) {
                   channel <- odbcConnectAccess(file)                       
                   data <- sqlQuery(channel, "select * from t_hdd")
                   close(channel)
                   return(data) 
                 })
output <- lapply(output, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
healthfacility <- rbind_all(output)

#write.csv(healthfacilities1, file = "health_facilitiesTOTAL.csv")
#write.csv(healthfacilities, file = "health_facilitiesTOTAL.csv")
#write.csv(healthfacility.counts, file = "health_facilityReduc.csv")



#run loop of selecting patient table from each DB, converting the columns to factors
list_filenames1 <- list.files(Parent.Folder, full.names = TRUE, recursive = FALSE)
acc_files1 <- list_filenames1[grep(".mdb", list_filenames1)]

output1 <- lapply(acc_files1, 
                  function(file) {
                    channel <- odbcConnectAccess(file)                       
                    data <- sqlQuery(channel, "select * from t_paciente")
                    close(channel)
                    return(data) 
                  })
output1 <- lapply(output1, function(x) {
  x[] <- lapply(x, as.factor)
  x
})
#combine using rbind to append parts of output
patient <- rbind_all(output1)


#rename column to common name of lowercase hdd
colnames(healthfacility)[colnames(healthfacility)=="HdD"] <- "hdd"

#join dataframes on common hdd column (basically patient rows will all get populated with facility data from hdd table)
test1<-left_join(patient,healthfacility, by="hdd")

#need to find UNIQUE nid, hdd. designacao in order to find accurate counts
####During this step, check New ID column for NA values - this indicates NIDs without NewID, which needs to be flagged; report which facility 
##also check previous step to see if column is named with different case and update
unique.patient.counts <- distinct(test1, nid, hdd, designacao, NewID)


#list of each facility (hdd) and the number of patients in each (# NIDs per hdd)
final.counts.byhdd <- count(unique.patient.counts, hdd)

#list of each designacao and the number of patients in each (# NIDs per designacao)
final.counts.bydesignacao <- count(unique.patient.counts, designacao, hdd)


##populate counts, presence of data and NewID in excel document for partner data submission tracking & feedback
############REMEMBER TO RUN SCRIPT SEPARATELY BY PARTNER, POPULATE COUNTS, THEN RUN FOR NEXT PARTNER & REPEAT####

write.csv(final.counts.bydesignacao, file = "final.counts.bydesignacao.csv")
write.csv(final.counts.byhdd, file = "final.counts.byhdd.csv")
write.csv(patient, file = "patient.csv")
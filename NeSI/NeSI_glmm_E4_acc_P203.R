# The current R file is run in NeSI to get the results for several models and save them as .RData file
message("Fitting model for P203_DataAnalysis.Rmd...")
jobid = Sys.getenv("SLURM_JOB_ID")
message(paste0("The corresponding *.out file is ", jobid, ".out"))

#############################  Preparation  ##############################
# set the working directory
message("Setting the current working directory...")
setwd("P203")

# load libraries
message("")
message("Loading the libraries...")
library(readr)
library(lme4)
library(lmerTest)

# load the data file
message("")
message("Loading the data file...")
load("E204_beha.RData")

#############################  Fitting the glmm max for accuracy  ##############################
# fit the glmm.max.acc.E4 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.max.acc.E4 model...")

# glmm.max.acc.E4 for mean amplitude
glmm.max.acc.E4 <- glmer(ACC ~ Type * Category * Duration +
                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
                           (1 + Dura_D | Stimuli),
                        data = clean.beha.E4,
                        family = "binomial",
                        verbose = TRUE,
                        control = glmerControl(optCtrl = list(maxfun = 1e5)))

source("get_pars.R")
glmm.max.acc.E4.pars <- get_pars(glmm.max.acc.E4)

glmm.max1.acc.E4 <- update(glmm.max.acc.E4,
                           start = glmm.max.acc.E4.pars)

# Saving glmm.max.acc.E4
message("")
message("Saving the glmm.max.acc.E4")
save(glmm.max.acc.E4, glmm.max1.acc.E4, file = "E204_acc_glmm_max.RData")


#############################  Fitting the glmm zcp for accuracy  ##############################
# # # fit the glmm.zcp.acc.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.zcp.acc.E4 model...")
# 
# # glmm.zcp.acc.E4 for mean amplitude
# load("E204_acc_glmm_max.RData")
# glmm.zcp.acc.E4 <- update(glmm.max.acc.E4,
#                          formula = ACC ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                            (1 + Dura_D || Stimuli)
#                          )
# 
# source("get_pars.R")
# glmm.zcp.acc.E4.pars <- get_pars(glmm.zcp.acc.E4)
# 
# glmm.zcp1.acc.E4 <- update(glmm.zcp.acc.E4,
#                            start = glmm.zcp.acc.E4.pars)
# 
# # Saving glmm.zcp.acc.E4
# message("")
# message("Saving the glmm.zcp.acc.E4")
# save(glmm.zcp.acc.E4, glmm.zcp1.acc.E4, file = "E204_acc_glmm_zcp.RData")


#############################  Fitting the glmm rdc for accuracy  ##############################
# # fit the glmm.rdc.acc.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.rdc.acc.E4 model...")
# 
# # glmm.rdc.acc.E4 for mean amplitude
# load("E204_acc_glmm_zcp.RData")
# glmm.rdc.acc.E4 <- update(glmm.zcp.acc.E4,
#                           formula = ACC ~ Type * Category * Duration + 
#                             (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                             (1 + Dura_D || Stimuli)
# )
# 
# message("Restarting fitting the glmm.rdc.acc.E4 model...")
# source("get_pars.R")
# glmm.rdc.acc.E4.pars <- get_pars(glmm.rdc.acc.E4)
# glmm.rdc1.acc.E4 <- update(glmm.rdc.acc.E4, start = glmm.rdc.acc.E4.pars)
# 
# # Saving glmm.rdc.acc.E4
# message("")
# message("Saving the glmm.rdc.acc.E4")
# save(glmm.rdc.acc.E4, glmm.rdc1.acc.E4, file = "E204_acc_glmm_rdc.RData")



#############################  Fitting the glmm etd for accuracy  ##############################
# # fit the glmm.etd.acc.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.etd.acc.E4 model...")
# 
# # glmm.etd.acc.E4 for mean amplitude
# load("E204_acc_glmm_rdc.RData")
# glmm.etd.acc.E4 <- update(glmm.rdc.acc.E4,
#                           formula = ACC ~ Type * Category * Duration + 
#                             (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                             (1 + Dura_D | Stimuli)
# )
# 
# message("Restarting fitting the glmm.etd.acc.E4 model...")
# source("get_pars.R")
# glmm.etd.acc.E4.pars <- get_pars(glmm.etd.acc.E4)
# glmm.etd1.acc.E4 <- update(glmm.etd.acc.E4, start = glmm.etd.acc.E4.pars)
# 
# # Saving glmm.etd.acc.E4
# message("")
# message("Saving the glmm.etd.acc.E4")
# save(glmm.etd.acc.E4, glmm.etd1.acc.E4, file = "E204_acc_glmm_etd.RData")


# versions of packages used
sessionInfo()
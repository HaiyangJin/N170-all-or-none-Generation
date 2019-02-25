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
load("E204_erp_P1.RData")

#############################  Fitting the lmm.max.P1 for P1  ##############################
# # fit the lmm.max.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.max.P1.E4 model...")
# 
# # lmm.max.P1 for mean amplitude
# lmm.max.P1.E4 <- lmer(MeanAmp ~ Type * Category * Duration * ACC + 
#                         (1 + Type_D + Cate_D + Dura_D + ACC_D + 
#                            Type_Cate + Type_Dura + Cate_Dura + Type_ACC + Cate_ACC + Dura_ACC +
#                            Type_Cate_Dura + Type_Cate_ACC + Type_Dura_ACC + Cate_Dura_ACC +
#                            Type_Cate_Dura_ACC | SubjCode),
#                       data = df.erp.P1.E4,
#                       REML = FALSE,
#                       # verbose = TRUE,
#                       control = lmerControl(optimizer = "bobyqa", 
#                                             optCtrl = list(maxfun = 1e6)))
# 
# # Saving lmm.max.P1.E4
# message("")
# message("Saving the lmm.max.acc.E4")
# save(lmm.max.P1.E4, file = "E204_P1_lmm_max.RData")


#############################  Fitting the lmm.zcp.P1 for P1  ##############################
# fit the lmm.zcp.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.P1 model...")
# 
# # lmm.zcp.P1 for mean amplitude
# load("E204_P1_lmm_max.RData")
# lmm.zcp.P1.E4 <- update(lmm.max.P1.E4, 
#                         formula = MeanAmp ~ Type * Category * Duration * ACC + 
#                           (1 + Type_D + Cate_D + Dura_D + ACC_D + 
#                              Type_Cate + Type_Dura + Cate_Dura + Type_ACC + Cate_ACC + Dura_ACC +
#                              Type_Cate_Dura + Type_Cate_ACC + Type_Dura_ACC + Cate_Dura_ACC +
#                              Type_Cate_Dura_ACC || SubjCode)
#                         # verbose = FALSE
#                         )
# 
# 
# # Saving lmm.zcp.P1
# message("")
# message("Saving the lmm.zcp.P1.E4")
# save(lmm.zcp.P1.E4, file = "E204_P1_lmm_zcp.RData")


#############################  Obtaining (step) the lmm.rdc.P1 for P1  ##############################
# reduce the lmm.zcp.P1 model
message("")
message(paste0(strrep("#", 80)))
message("Reducing the lmm.zcp.P1 model...")

load("E204_P1_lmm_zcp.RData")
lmm.zcp.P1.E4.step <- step(lmm.zcp.P1.E4, reduce.fixed = FALSE)

# Saving lmm.zcp.P1.step
message("")
message("Saving the lmm.zcp.P1.E4.step")
save(lmm.zcp.P1.E4.step, file = "E204_P1_lmm_zcp_step.RData")


# versions of packages used
sessionInfo()
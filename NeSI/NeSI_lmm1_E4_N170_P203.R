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
load("E204_erp_N170.RData")

#############################  Fitting the lmm.max.N170 for N170  ##############################
# fit the lmm.max.N170 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm1.max.N170.E4 model...")

# lmm1.max.N170 for mean amplitude
lmm1.max.N170.E4 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere + 
                           (1 + Type_D + Cate_D + Dura_D + Hemi_D + 
                              Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
                              Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi + 
                              Type_Cate_Dura_Hemi | SubjCode),
                         data = df.erp.N170.E4,
                         REML = FALSE,
                         verbose = TRUE,
                         control = lmerControl(optimizer = "Nelder_Mead",  # nloptwrap Nelder_Mead
                                               optCtrl = list(maxfun = 1e7)))

# Saving lmm.max.N170.E4
message("")
message("Saving the lmm.max.acc.E4")
save(lmm1.max.N170.E4, file = "E204_N170_lmm1_max.RData")


#############################  Fitting the lmm.zcp.N170 for N170  ##############################
# # fit the lmm.zcp.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.N170 model...")
# 
# # lmm.zcp.N170 for mean amplitude
# load("E204_N170_lmm_max.RData")
# lmm.zcp.N170.E4 <- update(lmm.max.N170.E4,
#                           formula = MeanAmp ~ Type * Category * Duration * Hemisphere * ACC +
#                             (1 + Type_D + Cate_D + Dura_D + Hemi_D + ACC_D +
#                                Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi + Type_ACC + Cate_ACC + Dura_ACC + Hemi_ACC +
#                                Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi + Type_Cate_ACC + Type_Dura_ACC + Cate_Dura_ACC +
#                                Type_Hemi_ACC + Cate_Hemi_ACC + Dura_Hemi_ACC +
#                                Type_Cate_Dura_Hemi + Type_Cate_Dura_ACC + Type_Cate_Hemi_ACC + Type_Hemi_Dura_ACC + Hemi_Cate_Dura_ACC +
#                                Type_Cate_Dura_Hemi_ACC || SubjCode),
#                           control = lmerControl(optimizer = "Nelder_Mead",
#                                                 optCtrl = list(maxfun = 1e7)))
# 
# # lmm.zcp.N170.E4 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere * ACC +
# #                           (1 + Type_D + Cate_D + Dura_D + Hemi_D + ACC_D +
# #                              Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi + Type_ACC + Cate_ACC + Dura_ACC + Hemi_ACC +
# #                              Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi + Type_Cate_ACC + Type_Dura_ACC + Cate_Dura_ACC +
# #                              Type_Hemi_ACC + Cate_Hemi_ACC + Dura_Hemi_ACC +
# #                              Type_Cate_Dura_Hemi + Type_Cate_Dura_ACC + Type_Cate_Hemi_ACC + Type_Hemi_Dura_ACC + Hemi_Cate_Dura_ACC +
# #                              Type_Cate_Dura_Hemi_ACC || SubjCode),
# #                         data = df.erp.N170.E4,
# #                         REML = FALSE,
# #                         verbose = TRUE,
# #                         control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
# #                                               optCtrl = list(maxfun = 1e7)))
# 
# # Saving lmm.zcp.N170
# message("")
# message("Saving the lmm.zcp.N170.E4")
# save(lmm.zcp.N170.E4, file = "E204_N170_lmm_zcp.RData")

#############################  Obtaining (step) the lmm.rdc.N170 for N170  ##############################
# # reduce the lmm.zcp.n170.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Reducing the lmm.zcp.N170.E4 model...")
# 
# load("E204_N170_lmm_zcp.RData")
# lmm.zcp.N170.E4.step <- step(lmm.zcp.N170.E4, reduce.fixed = FALSE)
# 
# # Saving lmm.zcp.N170.step
# message("")
# message("Saving the lmm.zcp.N170.E4.step")
# save(lmm.zcp.N170.E4.step, file = "E204_N170_lmm_zcp_step.RData")

#############################  Fitting the lmm.rdc.N170 for N170  ##############################
# # fit the lmm.rdc.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc.N170 model...")
# 
# # lmm.rdc.N170 for mean amplitude
# load("E204_N170_lmm_zcp.RData")
# lmm.rdc.N170.E4 <- update(lmm.zcp.N170.E4,
#                           formula = MeanAmp ~ Type * Category * Duration * Hemisphere * ACC +
#                             (1 + Type_D + Cate_D + Dura_D + Hemi_D + 
#                                Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi + Cate_ACC +
#                                Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_ACC || SubjCode))
# 
# # Saving lmm.rdc.N170
# message("")
# message("Saving the lmm.rdc.N170.E4")
# save(lmm.rdc.N170.E4, file = "E204_N170_lmm_rdc.RData")


#############################  Fitting the lmm.rdc1.N170 for N170  ##############################
# # fit the lmm.rdc1.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc1.N170 model...")
# 
# # lmm.rdc1.N170 for mean amplitude
# load("E204_N170_lmm_rdc.RData")
# lmm.rdc1.N170.E4 <- update(lmm.rdc.N170.E4,
#                           formula = MeanAmp ~ Type * Category * Duration * Hemisphere * ACC +
#                             (1 + Type_D + Cate_D + Dura_D + Hemi_D +
#                                Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi + Cate_ACC +
#                                Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_ACC || SubjCode))
# 
# # Saving lmm.rdc1.N170
# message("")
# message("Saving the lmm.rdc1.N170.E4")
# save(lmm.rdc1.N170.E4, file = "E204_N170_lmm_rdc1.RData")



# versions of packages used
sessionInfo()
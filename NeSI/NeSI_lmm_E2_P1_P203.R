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
library(lme4)
library(lmerTest)
source("get_pars.R")

# load the data file
message("")
message("Loading the data file...")
load("E205_erp_P1.RData")

#############################  Fitting the lmm.max.P1 for P1  ##############################
# # fit the lmm.max.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.max.P1.E2 model...")
# 
# # lmm.max.P1 for mean amplitude
# lmm.max.P1.E2 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere +
#                         (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                            Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                            Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi +
#                            Type_Cate_Dura_Hemi
#                          | SubjCode) +
#                         (1 + Type_C + Dura_C + Hemi_C +
#                            Type_Dura + Type_Hemi + Dura_Hemi +
#                            Type_Dura_Hemi
#                          | Stimuli),
#                       data = df.erp.P1.E2,
#                       verbose = TRUE,
#                       control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
#                                             optCtrl = list(maxfun = 1e7)))
# 
# # Saving lmm.max.P1.E2
# message("")
# message("Saving the lmm.max.P1.E2")
# save(lmm.max.P1.E2, file = "E205_P1_lmm_max.RData")


#############################  Fitting the lmm.zcp.P1 for P1  ##############################
# # fit the lmm.zcp.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.P1.E2 model...")
# 
# # lmm.zcp.P1 for mean amplitude
# lmm.zcp.P1.E2 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere +
#                         (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                            Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                            Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi +
#                            Type_Cate_Dura_Hemi
#                          || SubjCode) +
#                         (1 + Type_C + Dura_C + Hemi_C +
#                            Type_Dura + Type_Hemi + Dura_Hemi +
#                            Type_Dura_Hemi
#                          || Stimuli),
#                       data = df.erp.P1.E2,
#                       verbose = TRUE,
#                       control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
#                                             optCtrl = list(maxfun = 1e7)))
# 
# # Saving lmm.zcp.P1
# message("")
# message("Saving the lmm.zcp.P1.E2")
# save(lmm.zcp.P1.E2, file = "E205_P1_lmm_zcp.RData")


############################  Fitting the lmm.rdc.P1 for P1  ##############################
# # fit the lmm.rdc.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc.P1.E2 model...")
# 
# # lmm.rdc.P1 for mean amplitude
# load("E205_P1_lmm_zcp.RData")
# lmm.rdc.P1.E2 <- update(lmm.zcp.P1.E2,
#                         formula = MeanAmp ~ Type * Category * Duration * Hemisphere +
#                           (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                              Type_Cate + Type_Dura + Cate_Dura + Dura_Hemi
#                            || SubjCode) +
#                           (1 + Type_C + Dura_C +
#                              Type_Dura
#                            || Stimuli))
# 
# # Saving lmm.rdc.P1
# message("")
# message("Saving the lmm.rdc.P1.E2")
# save(lmm.rdc.P1.E2, file = "E205_P1_lmm_rdc.RData")


############################  Fitting the lmm.etd.P1 for P1  ##############################
# fit the lmm.etd.P1 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.etd.P1.E2 model...")

# lmm.etd.P1 for mean amplitude
load("E205_P1_lmm_rdc.RData")
lmm.etd.P1.E2 <- update(lmm.rdc.P1.E2,
                        formula = MeanAmp ~ Type * Category * Duration * Hemisphere +
                          (1 + Type_C + Cate_C + Dura_C + Hemi_C +
                             Type_Cate + Type_Dura + Cate_Dura + Dura_Hemi
                           | SubjCode) +
                          (1 + Type_C + Dura_C +
                             Type_Dura
                           | Stimuli))

lmm.etd.P1.E2.2 <- re_fit(lmm.etd.P1.E2)

# Saving lmm.etd.P1
message("")
message("Saving the lmm.etd.P1.E2")
save(lmm.etd.P1.E2, lmm.etd.P1.E2.2, file = "E205_P1_lmm_etd.RData")


############################  Fitting the lmm.etd1.P1 for P1  ##############################
# # fit the lmm.etd1.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd1.P1.E2 model...")
# 
# # lmm.etd1.P1 for mean amplitude
# load("E205_P1_lmm_etd.RData")
# lmm.etd1.P1.E2 <- update(lmm.etd.P1.E2,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 + Type_C + Dura_C + Hemi_C +  
#                               Type_Cate + Type_Dura + Cate_Dura + Dura_Hemi
#                             | SubjCode) +
#                            (0 + Type_C + Dura_C + 
#                               Type_Dura
#                             | Stimuli))
# 
# # Saving lmm.etd1.P1
# message("")
# message("Saving the lmm.etd1.P1.E2")
# save(lmm.etd1.P1.E2, file = "E205_P1_lmm_etd1.RData")


############################  Fitting the lmm.etd2.P1 for P1  ##############################
# # fit the lmm.etd2.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd2.P1.E2 model...")
# 
# # lmm.etd2.P1 for mean amplitude
# load("E205_P1_lmm_etd1.RData")
# lmm.etd2.P1.E2 <- update(lmm.etd1.P1.E2,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 + Type_C + Dura_C + Hemi_C +  
#                               Type_Cate + Type_Dura + Dura_Hemi
#                             | SubjCode) +
#                            (0 + Dura_C + 
#                               Type_Dura
#                             | Stimuli))
# 
# # Saving lmm.etd2.P1
# message("")
# message("Saving the lmm.etd2.P1.E2")
# save(lmm.etd2.P1.E2, file = "E205_P1_lmm_etd2.RData")


############################  Fitting the lmm.etd3.P1 for P1  ##############################
# # fit the lmm.etd3.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd3.P1.E2 model...")
# 
# # lmm.etd3.P1 for mean amplitude
# load("E205_P1_lmm_etd2.RData")
# lmm.etd3.P1.E2 <- update(lmm.etd2.P1.E2,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 + Dura_C + Hemi_C +  
#                               Type_Cate + Type_Dura + Dura_Hemi
#                             | SubjCode) +
#                            (0 + Dura_C + 
#                               Type_Dura
#                             | Stimuli))
# 
# # Saving lmm.etd3.P1
# message("")
# message("Saving the lmm.etd3.P1.E2")
# save(lmm.etd3.P1.E2, file = "E205_P1_lmm_etd3.RData")


############################  Fitting the lmm.opt.P1 for P1  ##############################
# # fit the lmm.opt.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.opt.P1.E2 model...")
# 
# # lmm.opt.P1 for mean amplitude
# load("E205_P1_lmm_rdc.RData")
# lmm.opt.P1.E2 <- update(lmm.rdc.P1.E2,
#                         REML = TRUE)
# 
# # Saving lmm.opt.P1
# message("")
# message("Saving the lmm.opt.P1.E2")
# save(lmm.opt.P1.E2, file = "E205_P1_lmm_opt.RData")



# versions of packages used
sessionInfo()

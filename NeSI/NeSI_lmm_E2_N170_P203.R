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

# load the data file
message("")
message("Loading the data file...")
load("E205_erp_N170.RData")

#############################  Fitting the lmm.max.N170 for N170  ##############################
# fit the lmm.max.N170 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.max.N170.E2 model...")

# lmm.max.N170 for mean amplitude
lmm.max.N170.E2 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere +
                          (1 + Type_C + Cate_C + Dura_C + Hemi_C +
                             Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
                             Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi +
                             Type_Cate_Dura_Hemi
                           | SubjCode) +
                          (1 + Type_C + Dura_C + Hemi_C +
                             Type_Dura + Type_Hemi + Dura_Hemi +
                             Type_Dura_Hemi
                           | Stimuli),
                        data = df.erp.N170.E2,
                        verbose = TRUE,
                        control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
                                              optCtrl = list(maxfun = 1e7)))

# Saving lmm.max.N170.E2
message("")
message("Saving the lmm.max.N170.E2")
save(lmm.max.N170.E2, file = "E205_N170_lmm_max.RData")


# #############################  Fitting the lmm.zcp.N170 for N170  ##############################
# # fit the lmm.zcp.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.N170.E2 model...")
# 
# # lmm.zcp.N170 for mean amplitude
# lmm.zcp.N170.E2 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere +
#                           (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                              Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                              Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi +
#                              Type_Cate_Dura_Hemi
#                            || SubjCode) +
#                           (1 + Type_C + Dura_C + Hemi_C +
#                              Type_Dura + Type_Hemi + Dura_Hemi +
#                              Type_Dura_Hemi
#                            || Stimuli),
#                         data = df.erp.N170.E2,
#                         verbose = TRUE,
#                         control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
#                                               optCtrl = list(maxfun = 1e7)))
# # Saving lmm.zcp.N170.E2
# message("")
# message("Saving the lmm.zcp.N170.E2")
# save(lmm.zcp.N170.E2, file = "E205_N170_lmm_zcp.RData")


############################  Fitting the lmm.rdc.N170 for N170  ##############################
# # fit the lmm.rdc.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc.N170.E2 model...")
# 
# # lmm.rdc.N170 for mean amplitude
# load("E205_N170_lmm_zcp.RData")
# lmm.rdc.N170.E2 <- update(lmm.zcp.N170.E2,
#                           formula = MeanAmp ~ Type * Category * Duration * Hemisphere +
#                             (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                                Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                                Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi
#                              || SubjCode) +
#                             (1 + Type_C + Dura_C +
#                                Type_Dura
#                              || Stimuli))
# 
# # Saving lmm.rdc.N170.E2
# message("")
# message("Saving the lmm.rdc.N170.E2")
# save(lmm.rdc.N170.E2, file = "E205_N170_lmm_rdc.RData")


############################  Fitting the lmm.etd.N170 for N170  ##############################
# # fit the lmm.etd.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd.N170.E2 model...")
# 
# # lmm.etd.N170 for mean amplitude
# load("E205_N170_lmm_rdc.RData")
# lmm.etd.N170.E2 <- update(lmm.rdc.N170.E2,
#                           formula = MeanAmp ~ Type * Category * Duration * Hemisphere +
#                             (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                                Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                                Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi
#                              | SubjCode) +
#                             (1 + Type_C + Dura_C +
#                                Type_Dura
#                              | Stimuli))
# 
# # Saving lmm.etd.N170.E2
# message("")
# message("Saving the lmm.etd.N170.E2")
# save(lmm.etd.N170.E2, file = "E205_N170_lmm_etd.RData")


############################  Fitting the lmm.etd1.N170 for N170  ##############################
# # fit the lmm.etd1.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd1.N170.E2 model...")
# 
# # lmm.etd1.N170 for mean amplitude
# load("E205_N170_lmm_etd.RData")
# lmm.etd1.N170.E2 <- update(lmm.etd.N170.E2,
#                            formula = MeanAmp ~ Type * Category * Duration * Hemisphere +
#                              (1 + Type_C + Dura_C + Hemi_C +
#                                 Type_Cate + Type_Dura + Type_Hemi + Dura_Hemi +
#                                 Type_Cate_Dura + Type_Cate_Hemi
#                               | SubjCode) +
#                              (1 + Type_C + Dura_C +
#                                 Type_Dura
#                               | Stimuli))
# 
# # Saving lmm.etd1.N170.E2
# message("")
# message("Saving the lmm.etd1.N170.E2")
# save(lmm.etd1.N170.E2, file = "E205_N170_lmm_etd1.RData")


############################  Fitting the lmm.etd2.N170 for N170  ##############################
# # fit the lmm.etd2.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd2.N170.E2 model...")
# 
# # lmm.etd2.N170 for mean amplitude
# load("E205_N170_lmm_etd1.RData")
# lmm.etd2.N170.E2 <- update(lmm.etd1.N170.E2,
#                            formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                              (1 + Type_C + Dura_C + Hemi_C +  
#                                 Type_Cate + Type_Dura + Dura_Hemi +
#                                 Type_Cate_Dura + Type_Cate_Hemi
#                               | SubjCode) +
#                              (1 + Type_C + Dura_C + 
#                                 Type_Dura
#                               | Stimuli))
# 
# # Saving lmm.etd2.N170.E2
# message("")
# message("Saving the lmm.etd2.N170.E2")
# save(lmm.etd2.N170.E2, file = "E205_N170_lmm_etd2.RData")


############################  Fitting the lmm.etd3.N170 for N170  ##############################
# # fit the lmm.etd3.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd3.N170.E2 model...")
# 
# # lmm.etd3.N170 for mean amplitude
# load("E205_N170_lmm_etd2.RData")
# lmm.etd3.N170.E2 <- update(lmm.etd2.N170.E2,
#                            formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                              (1 + Dura_C + Hemi_C +  
#                                 Type_Cate + Type_Dura + Dura_Hemi +
#                                 Type_Cate_Dura + Type_Cate_Hemi
#                               | SubjCode) +
#                              (0 + Type_C + Dura_C + 
#                                 Type_Dura
#                               | Stimuli))
# # Saving lmm.etd3.N170.E2
# message("")
# message("Saving the lmm.etd3.N170.E2")
# save(lmm.etd3.N170.E2, file = "E205_N170_lmm_etd3.RData")


# versions of packages used
sessionInfo()

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
load("E204_erp_P1.RData")

#############################  Fitting the lmm.max.P1 for P1  ##############################
# # fit the lmm.max.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.max.P1.E1 model...")
# 
# # lmm.max.P1 for mean amplitude
# lmm.max.P1.E1 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere * Response +
#                         (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                            Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                            Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi +
#                            Type_Cate_Dura_Hemi +
#                            Resp_C +
#                            Type_Resp + Cate_Resp + Dura_Resp + Hemi_Resp +
#                            Type_Cate_Resp + Type_Dura_Resp + Cate_Dura_Resp +
#                            Type_Hemi_Resp + Cate_Hemi_Resp + Dura_Hemi_Resp +
#                            Type_Cate_Dura_Resp + Type_Cate_Hemi_Resp + Type_Hemi_Dura_Resp + Hemi_Cate_Dura_Resp +
#                            Type_Cate_Dura_Hemi_Resp
#                          | SubjCode) +
#                         (1 + Type_C + Dura_C + Hemi_C +
#                            Type_Dura + Type_Hemi + Dura_Hemi +
#                            Type_Dura_Hemi +
#                            Resp_C +
#                            Type_Resp + Dura_Resp + Hemi_Resp +
#                            Type_Dura_Resp + Type_Hemi_Resp + Dura_Hemi_Resp +
#                            Type_Hemi_Dura_Resp
#                          | Stimuli),
#                       data = df.erp.P1.E1,
#                       verbose = TRUE,
#                       control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
#                                             optCtrl = list(maxfun = 1e7),
#                                             calc.derivs = FALSE))
# 
# # Saving lmm.max.P1.E1
# message("")
# message("Saving the lmm.max.P1.E1")
# save(lmm.max.P1.E1, file = "E204_P1_lmm_max.RData")


#############################  Fitting the lmm.zcp.P1 for P1  ##############################
# # fit the lmm.zcp.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.P1.E1 model...")
# 
# # lmm.zcp.P1 for mean amplitude
# lmm.zcp.P1.E1 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere * Response +
#                         (1 + Type_C + Cate_C + Dura_C + Hemi_C +
#                            Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
#                            Type_Cate_Dura + Type_Cate_Hemi + Type_Dura_Hemi + Cate_Dura_Hemi +
#                            Type_Cate_Dura_Hemi +
#                            Resp_C +
#                            Type_Resp + Cate_Resp + Dura_Resp + Hemi_Resp +
#                            Type_Cate_Resp + Type_Dura_Resp + Cate_Dura_Resp +
#                            Type_Hemi_Resp + Cate_Hemi_Resp + Dura_Hemi_Resp +
#                            Type_Cate_Dura_Resp + Type_Cate_Hemi_Resp + Type_Hemi_Dura_Resp + Hemi_Cate_Dura_Resp +
#                            Type_Cate_Dura_Hemi_Resp
#                          || SubjCode) +
#                         (1 + Type_C + Dura_C + Hemi_C +
#                            Type_Dura + Type_Hemi + Dura_Hemi +
#                            Type_Dura_Hemi +
#                            Resp_C +
#                            Type_Resp + Dura_Resp + Hemi_Resp +
#                            Type_Dura_Resp + Type_Hemi_Resp + Dura_Hemi_Resp +
#                            Type_Hemi_Dura_Resp
#                          || Stimuli),
#                       data = df.erp.P1.E1,
#                       verbose = TRUE,
#                       control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
#                                             optCtrl = list(maxfun = 1e7)))
# 
# 
# # Saving lmm.zcp.P1
# message("")
# message("Saving the lmm.zcp.P1.E1")
# save(lmm.zcp.P1.E1, file = "E204_P1_lmm_zcp.RData")


###########################  Fitting the lmm.rdc.P1 for P1  ##############################
# # fit the lmm.rdc.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc.P1.E1 model...")
# 
# # lmm.rdc.P1 for mean amplitude
# load("E204_P1_lmm_zcp.RData")
# lmm.rdc.P1.E1 <- update(lmm.zcp.P1.E1,
#                         formula = MeanAmp ~ Type * Category * Duration * Hemisphere * Response +
#                           (1 + Type_C + Cate_C + Dura_C + Hemi_C +  
#                              Type_Cate + Type_Dura + Type_Hemi + Dura_Hemi +
#                              Type_Cate_Dura +
#                              Resp_C +
#                              Type_Resp + Cate_Resp + Dura_Resp + 
#                              Cate_Hemi_Resp + Type_Dura_Resp +  
#                              Type_Cate_Dura_Resp
#                            || SubjCode) +
#                           (1 + Type_C + Dura_C + 
#                              Type_Dura +
#                              Resp_C + 
#                              Type_Resp + Dura_Resp + 
#                              Type_Dura_Resp
#                            || Stimuli))
# 
# # Saving lmm.rdc.P1
# message("")
# message("Saving the lmm.rdc.P1.E1")
# save(lmm.rdc.P1.E1, file = "E204_P1_lmm_rdc.RData")


###########################  Fitting the lmm.etd.P1 for P1  ##############################
# # fit the lmm.etd.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd.P1.E1 model...")
# 
# # lmm.etd.P1 for mean amplitude
# load("E204_P1_lmm_rdc.RData")
# lmm.etd.P1.E1 <- update(lmm.rdc.P1.E1,
#                         formula = MeanAmp ~ Type * Category * Duration * Hemisphere * Response +
#                           (1 + Type_C + Cate_C + Dura_C + Hemi_C +  
#                              Type_Cate + Type_Dura + Type_Hemi + Dura_Hemi +
#                              Type_Cate_Dura +
#                              Resp_C +
#                              Type_Resp + Cate_Resp + Dura_Resp + 
#                              Cate_Hemi_Resp + Type_Dura_Resp +  
#                              Type_Cate_Dura_Resp
#                            | SubjCode) +
#                           (1 + Type_C + Dura_C + 
#                              Type_Dura +
#                              Resp_C + 
#                              Type_Resp + Dura_Resp + 
#                              Type_Dura_Resp
#                            | Stimuli))
# 
# # Saving lmm.etd.P1
# message("")
# message("Saving the lmm.etd.P1.E1")
# save(lmm.etd.P1.E1, file = "E204_P1_lmm_etd.RData")


###########################  Fitting the lmm.etd1.P1 for P1  ##############################
# # fit the lmm.etd1.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd1.P1.E1 model...")
# 
# # lmm.etd1.P1 for mean amplitude
# load("E204_P1_lmm_etd.RData")
# lmm.etd1.P1.E1 <- update(lmm.etd.P1.E1,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere * Response +
#                            (1 + Hemi_C +  
#                               Type_Dura + 
#                               Type_Cate_Dura +
#                               Type_Resp + Cate_Resp + Dura_Resp + 
#                               Type_Dura_Resp +  
#                               Type_Cate_Dura_Resp
#                             | SubjCode) +
#                            (1 + Type_C + Dura_C + 
#                               Type_Dura +
#                               Resp_C + 
#                               Type_Resp + Dura_Resp + 
#                               Type_Dura_Resp
#                             | Stimuli))
# 
# # Saving lmm.etd1.P1
# message("")
# message("Saving the lmm.etd1.P1.E1")
# save(lmm.etd1.P1.E1, file = "E204_P1_lmm_etd1.RData")


###########################  Fitting the lmm.etd2.P1 for P1  ##############################
# # fit the lmm.etd2.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd2.P1.E1 model...")
# 
# # lmm.etd2.P1 for mean amplitude
# load("E204_P1_lmm_etd.RData")
# lmm.etd2.P1.E1 <- update(lmm.etd.P1.E1,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere * Response + 
#                            (1 + Hemi_C +  
#                               Type_Dura + 
#                               Type_Resp + 
#                               Type_Dura_Resp +  
#                               Type_Cate_Dura_Resp
#                             | SubjCode) +
#                            (0 + Type_C +  
#                               Type_Dura +
#                               Type_Resp + Dura_Resp + 
#                               Type_Dura_Resp
#                             | Stimuli))
# 
# # Saving lmm.etd2.P1
# message("")
# message("Saving the lmm.etd2.P1.E1")
# save(lmm.etd2.P1.E1, file = "E204_P1_lmm_etd2.RData")


###########################  Fitting the lmm.etd3.P1 for P1  ##############################
# fit the lmm.etd3.P1 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.etd3.P1.E1 model...")

# lmm.etd3.P1 for mean amplitude
load("E204_P1_lmm_etd2.RData")
lmm.etd3.P1.E1 <- update(lmm.etd2.P1.E1,
                         formula = MeanAmp ~ Type * Category * Duration * Hemisphere * Response + 
                           (1 + Hemi_C +  
                              Type_Resp + 
                              Type_Dura_Resp +  
                              Type_Cate_Dura_Resp
                            | SubjCode) +
                           (0 +  
                              Type_Dura +
                              Type_Resp + Dura_Resp + 
                              Type_Dura_Resp
                            | Stimuli))

# Saving lmm.etd3.P1
message("")
message("Saving the lmm.etd3.P1.E1")
save(lmm.etd3.P1.E1, file = "E204_P1_lmm_etd3.RData")


# versions of packages used
sessionInfo()

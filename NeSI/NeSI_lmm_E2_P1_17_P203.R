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
load("E205_erp_P1_17.RData")

#############################  Fitting the lmm.max.P1.17 for P1  ##############################
# fit the lmm.max.P1.17 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.max.P1.17.E2 model...")

# lmm.max.P1.17 for mean amplitude
lmm.max.P1.17.E2 <- lmer(MeanAmp ~ Category * Hemisphere * Confidence +
                           (1 + Cate_C + Hemi_C + ConLH_C + ConGL_C + 
                              Cate_ConLH + Hemi_ConLH +
                              Cate_Hemi_ConLH +
                              Cate_ConGL + Hemi_ConGL + 
                              Cate_Hemi_ConGL  
                            | SubjCode) +
                           
                           (1 + Hemi_C + ConLH_C + ConGL_C + 
                              Hemi_ConLH +
                              Hemi_ConGL 
                            | Stimuli),
                         
                         data = df.erp.P1.17.E2,
                         verbose = TRUE,
                         control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
                                               optCtrl = list(maxfun = 1e5)))

# Saving lmm.max.P1.17.E2
message("")
message("Saving the lmm.max.P1.17.E2")
save(lmm.max.P1.17.E2, file = "E205_P1_17_lmm_max.RData")


#############################  Fitting the lmm.zcp.P1.17 for P1  ##############################
# # fit the lmm.zcp.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.P1.17.E2 model...")
# 
# # lmm.zcp.P1.17 for mean amplitude
# load("E205_P1_17_lmm_max.RData")
# lmm.zcp.P1.17.E2 <- update(lmm.max.P1.17.E2,
#                            formula = MeanAmp ~ Category * Hemisphere * DuraConf +
#                              (1 + Cate_C + Hemi_C + ConLH_C + ConGL_C + Con2G_C + 
#                                 Cate_Hemi + Cate_ConLH + Cate_ConGL + Cate_Con2G +
#                                 Hemi_ConLH + Hemi_ConGL + Hemi_Con2G +
#                                 Cate_Hemi_ConLH + Cate_Hemi_ConGL + Cate_Hemi_Con2G
#                               || SubjCode) +
#                              (1 + Hemi_C + ConLH_C + ConGL_C + Con2G_C +
#                                 Hemi_ConLH + Hemi_ConGL + Hemi_Con2G 
#                               || Stimuli))
# 
# # Saving lmm.zcp.P1.17
# message("")
# message("Saving the lmm.zcp.P1.17.E2")
# save(lmm.zcp.P1.17.E2, file = "E205_P1_17_lmm_zcp.RData")


###########################  Fitting the lmm.zcp.P1.17 for P1  ##############################
# # fit the lmm.zcp.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.P1.17.E2.step model...")
# 
# # lmm.zcp.P1.17 for mean amplitude
# load("E205_P1_17_lmm_zcp.RData")
# lmm.zcp.P1.17.E2.step <- step(lmm.zcp.P1.17.E2, reduce.fixed = FALSE)
# 
# # Saving lmm.zcp.P1.17
# message("")
# message("Saving the lmm.zcp.P1.17.E2.step")
# save(lmm.zcp.P1.17.E2.step, file = "E205_P1_17_lmm_rdc_step.RData")


############################  Fitting the lmm.rdc.P1.17 for P1  ##############################
# # fit the lmm.rdc.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc.P1.17.E2 model...")
# 
# # lmm.rdc.P1.17 for mean amplitude
# load("E205_P1_17_lmm_zcp.RData")
# lmm.rdc.P1.17.E2 <- update(lmm.zcp.P1.17.E2,
#                            formula = MeanAmp ~ Category * Hemisphere * DuraConf +
#                              (0 + ConLH_C + Con2G_C + 
#                                 Cate_ConLH + 
#                                 Hemi_ConLH + Hemi_ConGL + Hemi_Con2G 
#                               || SubjCode) +
#                              (0 + ConLH_C + ConGL_C + Con2G_C
#                               || Stimuli))
# 
# # Saving lmm.rdc.P1.17
# message("")
# message("Saving the lmm.rdc.P1.17.E2")
# save(lmm.rdc.P1.17.E2, file = "E205_P1_17_lmm_rdc.RData")


# ############################  Fitting the lmm.rdc1.P1.17 for P1  ##############################
# # fit the lmm.rdc1.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc1.P1.17.E2 model...")
# 
# # lmm.rdc1.P1.17 for mean amplitude
# load("E205_P1_17_lmm_rdc.RData")
# lmm.rdc1.P1.17.E2 <- update(lmm.rdc.P1.17.E2,
#                            formula = MeanAmp ~ Category * Hemisphere * DuraConf +
#                              (0 + Con2G_C + 
#                                 Cate_ConLH + 
#                                 Hemi_ConLH + Hemi_ConGL + Hemi_Con2G 
#                               || SubjCode) +
#                              (0 + ConLH_C + ConGL_C + Con2G_C
#                               || Stimuli))
# 
# # Saving lmm.rdc1.P1.17
# message("")
# message("Saving the lmm.rdc1.P1.17.E2")
# save(lmm.rdc1.P1.17.E2, file = "E205_P1_17_lmm_rdc1.RData")


############################  Fitting the lmm.etd.P1.17 for P1  ##############################
# # fit the lmm.etd.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd.P1.17.E2 model...")
# 
# # lmm.etd.P1.17 for mean amplitude
# load("E205_P1_17_lmm_rdc.RData")
# lmm.etd.P1.17.E2 <- update(lmm.rdc.P1.17.E2,
#                         formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                           (1 + Type_C + Cate_C + Dura_C + Hemi_C +  
#                              Type_Cate + Type_Dura + Cate_Dura + Dura_Hemi
#                            | SubjCode) +
#                           (1 + Type_C + Dura_C + 
#                              Type_Dura
#                            | Stimuli))
# 
# # Saving lmm.etd.P1.17
# message("")
# message("Saving the lmm.etd.P1.17.E2")
# save(lmm.etd.P1.17.E2, file = "E205_P1_17_lmm_etd.RData")


############################  Fitting the lmm.etd1.P1.17 for P1  ##############################
# # fit the lmm.etd1.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd1.P1.17.E2 model...")
# 
# # lmm.etd1.P1.17 for mean amplitude
# load("E205_P1_17_lmm_etd.RData")
# lmm.etd1.P1.17.E2 <- update(lmm.etd.P1.17.E2,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 + Type_C + Dura_C + Hemi_C +  
#                               Type_Cate + Type_Dura + Cate_Dura + Dura_Hemi
#                             | SubjCode) +
#                            (0 + Type_C + Dura_C + 
#                               Type_Dura
#                             | Stimuli))
# 
# # Saving lmm.etd1.P1.17
# message("")
# message("Saving the lmm.etd1.P1.17.E2")
# save(lmm.etd1.P1.17.E2, file = "E205_P1_17_lmm_etd1.RData")


############################  Fitting the lmm.etd2.P1.17 for P1  ##############################
# # fit the lmm.etd2.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd2.P1.17.E2 model...")
# 
# # lmm.etd2.P1.17 for mean amplitude
# load("E205_P1_17_lmm_etd1.RData")
# lmm.etd2.P1.17.E2 <- update(lmm.etd1.P1.17.E2,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 + Type_C + Dura_C + Hemi_C +  
#                               Type_Cate + Type_Dura + Dura_Hemi
#                             | SubjCode) +
#                            (0 + Dura_C + 
#                               Type_Dura
#                             | Stimuli))
# 
# # Saving lmm.etd2.P1.17
# message("")
# message("Saving the lmm.etd2.P1.17.E2")
# save(lmm.etd2.P1.17.E2, file = "E205_P1_17_lmm_etd2.RData")


############################  Fitting the lmm.etd3.P1.17 for P1  ##############################
# # fit the lmm.etd3.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd3.P1.17.E2 model...")
# 
# # lmm.etd3.P1.17 for mean amplitude
# load("E205_P1_17_lmm_etd2.RData")
# lmm.etd3.P1.17.E2 <- update(lmm.etd2.P1.17.E2,
#                          formula = MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 + Dura_C + Hemi_C +  
#                               Type_Cate + Type_Dura + Dura_Hemi
#                             | SubjCode) +
#                            (0 + Dura_C + 
#                               Type_Dura
#                             | Stimuli))
# 
# # Saving lmm.etd3.P1.17
# message("")
# message("Saving the lmm.etd3.P1.17.E2")
# save(lmm.etd3.P1.17.E2, file = "E205_P1_17_lmm_etd3.RData")


############################  Fitting the lmm.opt.P1.17 for P1  ##############################
# # fit the lmm.opt.P1.17 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.opt.P1.17.E2 model...")
# 
# # lmm.opt.P1.17 for mean amplitude
# load("E205_P1_17_lmm_rdc.RData")
# lmm.opt.P1.17.E2 <- update(lmm.rdc.P1.17.E2,
#                         REML = TRUE)
# 
# # Saving lmm.opt.P1.17
# message("")
# message("Saving the lmm.opt.P1.17.E2")
# save(lmm.opt.P1.17.E2, file = "E205_P1_17_lmm_opt.RData")



# versions of packages used
sessionInfo()

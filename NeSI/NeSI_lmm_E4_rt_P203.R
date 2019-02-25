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
load("E204_beha_RT.RData")

#############################  Fitting the lmm max for response times  ##############################
# fit the lmm.max.trial model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.max.trial model...")

# lmm.max.rt.E4 for mean amplitude
lmm.max.rt.E4 <- lmer(RT ~ Type * Category * Duration +
                        (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
                        (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | Stimuli),
                      data = df.rt.E4,
                      REML = FALSE,
                      control = lmerControl(optimizer = "bobyqa",
                                            optCtrl = list(maxfun = 1e5)))

# Saving lmm.max.rt.E4
message("")
message("Saving the lmm.max.rt.E4")
save(lmm.max.rt.E4, file = "E204_rt_lmm_max.RData")


#############################  Fitting the lmm zcp for response times  ##############################
# # fit the lmm.zcp.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.rt.E4 model...")
# 
# # lmm.zcp.rt.E4 for mean amplitude
# load("E204_rt_lmm_max.RData")
# lmm.zcp.rt.E4 <- update(lmm.max.rt.E4,
#                          formula = RT ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || Stimuli)
#                          # verbose = TRUE
#                          )
# 
# # Saving lmm.zcp.rt.E4
# message("")
# message("Saving the lmm.zcp.rt.E4")
# save(lmm.zcp.rt.E4, file = "E204_rt_lmm_zcp.RData")


#############################  Fitting the lmm rdc for response times  ##############################
# # fit the lmm.rdc.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.rdc.rt.E4 model...")
# 
# # lmm.rdc.rt.E4 for mean amplitude
# load("E204_rt_lmm_zcp.RData")
# lmm.rdc.rt.E4 <- update(lmm.zcp.rt.E4,
#                          formula = RT ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                            (1 + Type_D + Dura_D + Type_Dura + Type_Cate_Dura || Stimuli))
# 
# # Saving lmm.rdc.rt.E4
# message("")
# message("Saving the lmm.rdc.rt.E4")
# save(lmm.rdc.rt.E4, file = "E204_rt_lmm_rdc.RData")


#############################  Fitting the lmm etd for response times  ##############################
# # fit the lmm.etd.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd.rt.E4 model...")
# 
# # lmm.etd.rt.E4 for mean amplitude
# load("E204_rt_lmm_rdc.RData")
# lmm.etd.rt.E4 <- update(lmm.rdc.rt.E4,
#                          formula = RT ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                            (1 + Type_D + Dura_D + Type_Dura + Type_Cate_Dura | Stimuli))
# 
# # Saving lmm.etd.rt.E4
# message("")
# message("Saving the lmm.etd.rt.E4")
# save(lmm.etd.rt.E4, file = "E204_rt_lmm_etd.RData")


#############################  refit extended model  ##############################
# # fit the lmm.etd.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("allFit the lmm.etd.rt.E4 model...")
# 
# # lmm.etd.rt.E4 for mean amplitude
# source("get_pars.R")
# load("E204_rt_lmm_etd.RData")
# 
# pars.etd.rt.E4 <- get_pars(lmm.etd.rt.E4) 
# 
# lmm.etd1.rt.E4 <- update(lmm.etd.rt.E4, start = pars.etd.rt.E4) 
# 
# # Saving lmm.etd.rt.E4
# message("")
# message("Saving the allFit.lmm.etd.rt.E4")
# save(lmm.etd1.rt.E4, file = "E204_rt_lmm_etd1.RData")



#############################  allFit for extended model  ##############################
# # fit the lmm.etd.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("allFit the lmm.etd.rt.E4 model...")
# 
# # lmm.etd.rt.E4 for mean amplitude
# lmm.etd.rt.E4 <- glmer(RT ~ Type * Category * Duration +
#                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                           (1 + Type_D + Dura_D + Type_Dura + Type_Cate_Dura | Stimuli),
#                         data = df.rt.E4,
#                         family = "poisson"
#                         )
# allFit.lmm.etd.rt.E4 <- allFit(lmm.etd.rt.E4,
#                                 maxfun = 1e6)
# 
# # Saving lmm.etd.rt.E4
# message("")
# message("Saving the allFit.lmm.etd.rt.E4")
# save(allFit.lmm.etd.rt.E4, file = "E204_rt_lmm_etd_allFit.RData")


#############################  Fitting the lmm etd2 for response times  ##############################
# # fit the lmm.etd2.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd2.rt.E4 model...")
# 
# # lmm.etd2.rt.E4 for mean amplitude
# load("E204_rt_lmm_etd.RData")
# lmm.etd2.rt.E4 <- update(lmm.etd.rt.E4,
#                           formula = RT ~ Type * Category * Duration +
#                             (1 + Type_D + Cate_D + Type_Cate + Type_Dura + Type_Cate_Dura | SubjCode) +
#                             (0 + Type_D + Type_Dura + Type_Cate_Dura | Stimuli))
# 
# # Saving lmm.etd2.rt.E4
# message("")
# message("Saving the lmm.etd2.rt.E4")
# save(lmm.etd2.rt.E4, file = "E204_rt_lmm_etd2.RData")


#############################  Fitting the lmm etd3 for response times  ##############################
# # fit the lmm.etd2.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd3.rt.E4 model...")
# 
# # lmm.etd3.rt.E4 for mean amplitude
# load("E204_rt_lmm_etd2.RData")
# lmm.etd3.rt.E4 <- update(lmm.etd2.rt.E4,
#                           formula = RT ~ Type * Category * Duration +
#                             (1 + Type_D + Cate_D + Type_Cate + Type_Dura + Type_Cate_Dura | SubjCode) +
#                             (0 + Type_D + Type_Dura + Type_Cate_Dura | Stimuli))
# 
# # Saving lmm.etd3.rt.E4
# message("")
# message("Saving the lmm.etd3.rt.E4")
# save(lmm.etd3.rt.E4, file = "E204_rt_lmm_etd3.RData")




# versions of packages used
rstudioapi::versionInfo()
sessionInfo()
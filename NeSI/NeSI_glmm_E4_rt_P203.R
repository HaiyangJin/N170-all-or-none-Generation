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

#############################  Fitting the glmm max for response times  ##############################
# # fit the glmm.max.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.max.rt.E4 model...")
# 
# # glmm.max.rt.E4 for mean amplitude
# glmm.max.rt.E4 <- glmer(RT ~ Type * Category * Duration +
#                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                           (1 + Dura_D | Stimuli),
#                         data = df.rt.E4,
#                         family = "poisson",
#                         control = glmerControl(optCtrl = list(maxfun = 1e5)))
# 
# # Saving glmm.max.rt.E4
# message("")
# message("Saving the glmm.max.rt.E4")
# save(glmm.max.rt.E4, file = "E204_rt_glmm_max.RData")


#############################  Fitting the glmm zcp for response times  ##############################
# fit the glmm.zcp.rt.E4 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.zcp.rt.E4 model...")

# glmm.zcp.rt.E4 for mean amplitude
load("E204_rt_glmm_max.RData")
glmm.zcp.rt.E4 <- update(glmm.max.rt.E4,
                         formula = RT ~ Type * Category * Duration +
                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
                           (1 + Dura_D || Stimuli)
                         # verbose = TRUE
                         )

# Saving glmm.zcp.rt.E4
message("")
message("Saving the glmm.zcp.rt.E4")
save(glmm.zcp.rt.E4, file = "E204_rt_glmm_zcp.RData")


#############################  Fitting the glmm rdc for response times  ##############################
# # fit the glmm.rdc.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.rdc.rt.E4 model...")
# 
# # glmm.rdc.rt.E4 for mean amplitude
# load("E204_rt_glmm_zcp.RData")
# glmm.rdc.rt.E4 <- update(glmm.zcp.rt.E4,
#                          formula = RT ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                            (1 + Type_D + Dura_D + Type_Dura + Type_Cate_Dura || Stimuli))
# 
# # Saving glmm.rdc.rt.E4
# message("")
# message("Saving the glmm.rdc.rt.E4")
# save(glmm.rdc.rt.E4, file = "E204_rt_glmm_rdc.RData")


#############################  Fitting the glmm etd for response times  ##############################
# # fit the glmm.etd.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.etd.rt.E4 model...")
# 
# # glmm.etd.rt.E4 for mean amplitude
# load("E204_rt_glmm_rdc.RData")
# glmm.etd.rt.E4 <- update(glmm.rdc.rt.E4,
#                          formula = RT ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                            (1 + Type_D + Dura_D + Type_Dura + Type_Cate_Dura | Stimuli))
# 
# # Saving glmm.etd.rt.E4
# message("")
# message("Saving the glmm.etd.rt.E4")
# save(glmm.etd.rt.E4, file = "E204_rt_glmm_etd.RData")


#############################  refit extended model  ##############################
# # fit the glmm.etd.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("allFit the glmm.etd.rt.E4 model...")
# 
# # glmm.etd.rt.E4 for mean amplitude
# source("get_pars.R")
# load("E204_rt_glmm_etd.RData")
# 
# pars.etd.rt.E4 <- get_pars(glmm.etd.rt.E4) 
# 
# glmm.etd1.rt.E4 <- update(glmm.etd.rt.E4, start = pars.etd.rt.E4) 
# 
# # Saving glmm.etd.rt.E4
# message("")
# message("Saving the allFit.glmm.etd.rt.E4")
# save(glmm.etd1.rt.E4, file = "E204_rt_glmm_etd1.RData")



#############################  allFit for extended model  ##############################
# # fit the glmm.etd.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("allFit the glmm.etd.rt.E4 model...")
# 
# # glmm.etd.rt.E4 for mean amplitude
# glmm.etd.rt.E4 <- glmer(RT ~ Type * Category * Duration +
#                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                           (1 + Type_D + Dura_D + Type_Dura + Type_Cate_Dura | Stimuli),
#                         data = df.rt.E4,
#                         family = "poisson"
#                         )
# allFit.glmm.etd.rt.E4 <- allFit(glmm.etd.rt.E4,
#                                 maxfun = 1e6)
# 
# # Saving glmm.etd.rt.E4
# message("")
# message("Saving the allFit.glmm.etd.rt.E4")
# save(allFit.glmm.etd.rt.E4, file = "E204_rt_glmm_etd_allFit.RData")


#############################  Fitting the glmm etd2 for response times  ##############################
# # fit the glmm.etd2.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.etd2.rt.E4 model...")
# 
# # glmm.etd2.rt.E4 for mean amplitude
# load("E204_rt_glmm_etd.RData")
# glmm.etd2.rt.E4 <- update(glmm.etd.rt.E4,
#                           formula = RT ~ Type * Category * Duration +
#                             (1 + Type_D + Cate_D + Type_Cate + Type_Dura + Type_Cate_Dura | SubjCode) +
#                             (0 + Type_D + Type_Dura + Type_Cate_Dura | Stimuli))
# 
# # Saving glmm.etd2.rt.E4
# message("")
# message("Saving the glmm.etd2.rt.E4")
# save(glmm.etd2.rt.E4, file = "E204_rt_glmm_etd2.RData")


#############################  Fitting the glmm etd3 for response times  ##############################
# # fit the glmm.etd2.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.etd3.rt.E4 model...")
# 
# # glmm.etd3.rt.E4 for mean amplitude
# load("E204_rt_glmm_etd2.RData")
# glmm.etd3.rt.E4 <- update(glmm.etd2.rt.E4,
#                           formula = RT ~ Type * Category * Duration +
#                             (1 + Type_D + Cate_D + Type_Cate + Type_Dura + Type_Cate_Dura | SubjCode) +
#                             (0 + Type_D + Type_Dura + Type_Cate_Dura | Stimuli))
# 
# # Saving glmm.etd3.rt.E4
# message("")
# message("Saving the glmm.etd3.rt.E4")
# save(glmm.etd3.rt.E4, file = "E204_rt_glmm_etd3.RData")




# versions of packages used
sessionInfo()
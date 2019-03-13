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

#############################  Fitting the glmm max for response  ##############################
# # fit the glmm.max.resp.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.max.resp.E4 model...")
# 
# # glmm.max.resp.E4 for mean amplitude
# glmm.max.resp.E4 <- glmer(ACC ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                            (1 + Dura_D | Stimuli),
#                         data = clean.beha.E4,
#                         family = "binomial",
#                         verbose = TRUE,
#                         control = glmerControl(optCtrl = list(maxfun = 1e5)))
# 
# source("get_pars.R")
# glmm.max1.resp.E4 <- re_fit(glmm.max.resp.E4)
# 
# # Saving glmm.max.resp.E4
# message("")
# message("Saving the glmm.max.resp.E4")
# save(glmm.max.resp.E4, glmm.max1.resp.E4, file = "E204_resp_glmm_max.RData")


#############################  Fitting the glmm zcp for response  ##############################
# # fit the glmm.zcp.resp.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.zcp.resp.E4 model...")
# 
# # glmm.zcp.resp.E4 for mean amplitude
# load("E204_resp_glmm_max.RData")
# glmm.zcp.resp.E4 <- update(glmm.max.resp.E4,
#                          formula = ACC ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                            (1 + Dura_D || Stimuli)
#                          )
# 
# source("get_pars.R")
# glmm.zcp1.resp.E4 <- re_fit(glmm.zcp.resp.E4)
# 
# # Saving glmm.zcp.resp.E4
# message("")
# message("Saving the glmm.zcp.resp.E4")
# save(glmm.zcp.resp.E4, glmm.zcp1.resp.E4, file = "E204_resp_glmm_zcp.RData")


#############################  allFitting the glmm zcp for response  ##############################
# fit the glmm.zcp.resp.E4 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.max.resp.E4.allFit model...")

# glmm.max.resp.E4.allFit for mean amplitude
glmm.max0.resp.E4 <- glmer(ACC ~ Type * Category * Duration +
                             (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
                             (1 + Dura_D | Stimuli),
                           data = clean.beha.E4,
                           family = "binomial")

glmm.max.resp.E4.allFit = allFit(glmm.max0.resp.E4,
                                 verbose = TRUE,
                                 maxfun = 1e6)

# Saving glmm.zcp.resp.E4
message("")
message("Saving the glmm.zcp.resp.E4")
save(glmm.max.resp.E4.allFit, file = "E204_resp_glmm_max_allFit.RData")


# versions of packages used
sessionInfo()
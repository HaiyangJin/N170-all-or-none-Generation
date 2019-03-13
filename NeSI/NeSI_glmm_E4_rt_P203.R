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
# # fit the glmm.zcp.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.zcp.rt.E4 model...")
# 
# # glmm.zcp.rt.E4 for mean amplitude
# load("E204_rt_glmm_max.RData")
# glmm.zcp.rt.E4 <- update(glmm.max.rt.E4,
#                          formula = RT ~ Type * Category * Duration +
#                            (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                            (1 + Dura_D || Stimuli)
#                          # verbose = TRUE
#                          )
# 
# # Saving glmm.zcp.rt.E4
# message("")
# message("Saving the glmm.zcp.rt.E4")
# save(glmm.zcp.rt.E4, file = "E204_rt_glmm_zcp.RData")


#############################  Fitting the glmm max1 for response times  ##############################
# # fit the glmm.max1.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.max1.rt.E4 model...")
# 
# # glmm.max1.rt.E4 for mean amplitude
# source("get_pars.R")
# load("E204_rt_glmm_max.RData")
# glmm.max1.rt.E4 <- re_fit(glmm.max.rt.E4)
# 
# # Saving glmm.max1.rt.E4
# message("")
# message("Saving the glmm.max1.rt.E4")
# save(glmm.max1.rt.E4, file = "E204_rt_glmm_max1.RData")


#############################  Fitting the glmm max2 for response times  ##############################
# # fit the glmm.max2.rt.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.max2.rt.E4 model...")
# 
# # glmm.max2.rt.E4 for mean amplitude
# source("get_pars.R")
# load("E204_rt_glmm_max1.RData")
# glmm.max2.rt.E4 <- re_fit(glmm.max1.rt.E4)
# 
# # Saving glmm.max2.rt.E4
# message("")
# message("Saving the glmm.max2.rt.E4")
# save(glmm.max2.rt.E4, file = "E204_rt_glmm_max2.RData")


#############################  Fitting the glmm allFit for response times  ##############################
# fit the glmm.max.rt.E4.allFit model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.max.rt.E4.allFit model...")

# glmm.max.rt.E4.allFit for mean amplitude
glmm.max0.rt.E4 <- glmer(RT ~ Type * Category * Duration +
                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
                           (1 + Dura_D | Stimuli),
                         data = df.rt.E4,
                         family = "poisson")

glmm.max.rt.E4.allFit = allFit(glmm.max0.rt.E4,
                               maxfun = 1e6)

# Saving glmm.max.rt.E4.allFit
message("")
message("Saving the glmm.max.rt.E4.allFit")
save(glmm.max.rt.E4.allFit, file = "E204_rt_glmm_max_allFit.RData")


# versions of packages used
sessionInfo()
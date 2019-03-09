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
# fit the glmm.zcp.resp.E4 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.zcp.resp.E4 model...")

# glmm.zcp.resp.E4 for mean amplitude
load("E204_resp_glmm_max.RData")
glmm.zcp.resp.E4 <- update(glmm.max.resp.E4,
                         formula = ACC ~ Type * Category * Duration +
                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
                           (1 + Dura_D || Stimuli)
                         )

source("get_pars.R")
glmm.zcp1.resp.E4 <- re_fit(glmm.zcp.resp.E4)

# Saving glmm.zcp.resp.E4
message("")
message("Saving the glmm.zcp.resp.E4")
save(glmm.zcp.resp.E4, glmm.zcp1.resp.E4, file = "E204_resp_glmm_zcp.RData")


#############################  Fitting the glmm rdc for response  ##############################
# # fit the glmm.rdc.resp.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.rdc.resp.E4 model...")
# 
# # glmm.rdc.resp.E4 for mean amplitude
# load("E204_resp_glmm_zcp.RData")
# glmm.rdc.resp.E4 <- update(glmm.zcp.resp.E4,
#                           formula = ACC ~ Type * Category * Duration + 
#                             (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
#                             (1 + Dura_D || Stimuli)
# )
# 
# message("Restarting fitting the glmm.rdc.resp.E4 model...")
# source("get_pars.R")
# glmm.rdc.resp.E4.pars <- get_pars(glmm.rdc.resp.E4)
# glmm.rdc1.resp.E4 <- update(glmm.rdc.resp.E4, start = glmm.rdc.resp.E4.pars)
# 
# # Saving glmm.rdc.resp.E4
# message("")
# message("Saving the glmm.rdc.resp.E4")
# save(glmm.rdc.resp.E4, glmm.rdc1.resp.E4, file = "E204_resp_glmm_rdc.RData")



#############################  Fitting the glmm etd for response  ##############################
# # fit the glmm.etd.resp.E4 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the glmm.etd.resp.E4 model...")
# 
# # glmm.etd.resp.E4 for mean amplitude
# load("E204_resp_glmm_rdc.RData")
# glmm.etd.resp.E4 <- update(glmm.rdc.resp.E4,
#                           formula = ACC ~ Type * Category * Duration + 
#                             (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                             (1 + Dura_D | Stimuli)
# )
# 
# message("Restarting fitting the glmm.etd.resp.E4 model...")
# source("get_pars.R")
# glmm.etd.resp.E4.pars <- get_pars(glmm.etd.resp.E4)
# glmm.etd1.resp.E4 <- update(glmm.etd.resp.E4, start = glmm.etd.resp.E4.pars)
# 
# # Saving glmm.etd.resp.E4
# message("")
# message("Saving the glmm.etd.resp.E4")
# save(glmm.etd.resp.E4, glmm.etd1.resp.E4, file = "E204_resp_glmm_etd.RData")


# versions of packages used
sessionInfo()
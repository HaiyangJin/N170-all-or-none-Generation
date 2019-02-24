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

#############################  Fitting the lmm.max.trial for raw mean amplitude  ##############################
# # fit the lmm.max.trial model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.max.trial model...")
# 
# # lmm.max.trial for mean amplitude
# lmm.max.acc.E4 <- glmer(ACC ~ Type * Category * Duration + 
#                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | SubjCode) +
#                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura | Stimuli),
#                         data = clean.beha.E4,
#                         family = "binomial",
#                         control = glmerControl(optCtrl = list(maxfun = 1e5)))
# 
# # Saving lmm.max.trial
# message("")
# message("Saving the lmm.max.acc.E4")
# save(lmm.max.acc.E4, file = "E204_lmm_max_acc.RData")


#############################  Fitting the lmm.zcp.trial for raw mean amplitude  ##############################
# fit the lmm.zcp.trial model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.zcp.trial model...")

# lmm.zcp.trial for mean amplitude
load("E204_max_acc.RData")
lmm.zcp.acc.E4 <- update(lmm.max.acc.E4,
                         formula = ACC ~ Type * Category * Duration + 
                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || SubjCode) +
                           (1 + Type_D + Cate_D + Dura_D + Type_Cate + Type_Dura + Cate_Dura + Type_Cate_Dura || Stimuli)
                         # verbose = TRUE
                         )

# Saving lmm.zcp.trial
message("")
message("Saving the lmm.zcp.acc.E4")
save(lmm.zcp.acc.E4, file = "E204_lmm_zcp_acc.RData")



# versions of packages used
sessionInfo()
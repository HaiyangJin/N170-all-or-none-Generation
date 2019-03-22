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
load("E204_erp_P1.RData")

#############################  Fitting the lmm.P1.E4.1 for P1  ##############################
# # fit the lmm.max.P1 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.P1.E4.1 model...")
# 
# # lmm.P1.E4.1 for mean amplitude
# lmm.P1.E4.1 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere * ACC +
#                       (1 + Type_D + Cate_D + Dura_D + Hemi_D + ACC_D | SubjCode),
#                     data = df.erp.P1.E4,
#                     REML = FALSE,
#                     control = lmerControl(optimizer = "bobyqa")) 
# 
# # Saving lmm.max.P1.E4
# message("")
# message("Saving the lmm.P1.E4.1")
# save(lmm.P1.E4.1, file = "E204_P1_lmm_1.RData")


#############################  Fitting the lmm.P1.E4.2 for P1  ##############################
# fit the lmm.max.P1 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.P1.E4.2 model...")

# lmm.P1.E4.2 for mean amplitude
load("E204_P1_lmm_1.RData")
lmm.P1.E4.2 <- update(lmm.P1.E4.1,
                      formula = MeanAmp ~ Type * Category * Duration * Hemisphere * ACC +
                        (1 + Type_D + Cate_D + Dura_D + Hemi_D + ACC_D +
                           Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi + Type_ACC + Cate_ACC + Dura_ACC + Hemi_ACC | SubjCode),
                      verbose = TRUE,
                      control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
                                            optCtrl = list(maxfun = 1e7)))

# Saving lmm.max.P1.E4
message("")
message("Saving the lmm.P1.E4.2")
save(lmm.P1.E4.2, file = "E204_P1_lmm_2.RData")


# versions of packages used
sessionInfo()
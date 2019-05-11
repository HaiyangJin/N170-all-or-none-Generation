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
load("E204_erp_N170.RData")

#############################  Fitting the lmm0.int.N170 for N170  ##############################
# # fit the lmm0.int.N170 model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm0.int.N170.E4 model...")
# 
# # lmm0.int.N170 for mean amplitude
# lmm0.int.N170.E4 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere + 
#                            (1 | SubjCode),
#                          data = df.erp.N170.E4,
#                          REML = FALSE,
#                          verbose = TRUE,
#                          control = lmerControl(optimizer = "Nelder_Mead",  # nloptwrap Nelder_Mead
#                                                optCtrl = list(maxfun = 1e7)))
# 
# # Saving lmm0.int.N170.E4
# message("")
# message("Saving the lmm0.int.acc.E4")
# save(lmm0.int.N170.E4, file = "E204_N170_lmm0_int.RData")


#############################  Fitting the lmm0.etd.N170 for N170  ##############################
# fit the lmm0.etd.N170 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm0.etd.N170.E4 model...")

# lmm0.etd.N170 for mean amplitude
lmm0.etd.N170.E4 <- lmer(MeanAmp ~ Type * Category * Duration * Hemisphere + 
                           (1 + Type_D + Cate_D + Dura_D + Hemi_D + 
                              Type_Cate + Type_Dura + Cate_Dura + Type_Hemi + Cate_Hemi + Dura_Hemi +
                              Type_Cate_Dura + Type_Cate_Hemi | SubjCode),
                         data = df.erp.N170.E4,
                         REML = FALSE,
                         # verbose = TRUE,
                         control = lmerControl(optimizer = "bobyqa",  # nloptwrap Nelder_Mead
                                               optCtrl = list(maxfun = 1e7)))

# Saving lmm0.etd.N170.E4
message("")
message("Saving the lmm0.etd.acc.E4")
save(lmm0.etd.N170.E4, file = "E204_N170_lmm0_etd.RData")


# versions of packages used
sessionInfo()
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

#############################  Fitting the lmm.max.P1 for P1  ##############################
# fit the lmm.max.P1 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the lmm.max.P1.E4 model...")

# lmm.P1.E4.5 for mean amplitude
load("E204_P1_lmm_4.RData")
lmm.P1.E4.5 <- update(lmm.P1.E4.4,
                      formula = MeanAmp ~ Type * Category * Duration * ACC + 
                        (1 + Type * Category * Duration | SubjCode),
                      control = lmerControl(optCtrl = list(maxfun = 1e7)))

# Saving lmm.max.P1.E4
message("")
message("Saving the lmm.P1.E4.5")
save(lmm.P1.E4.5, file = "E204_P1_lmm_5.RData")


# versions of packages used
sessionInfo()
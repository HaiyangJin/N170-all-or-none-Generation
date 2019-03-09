# get parameters from the model (and will be applied to the start of the to-be-refitted model)
# codes are mainly from https://rdrr.io/cran/lme4/man/convergence.html
# Author: Haiyang Jin (https://haiyangjin.github.io/portfolio/)

get_pars <- function(lmm) {
    # lmm is the (generalized) linear mixed model
    if (isLMM(lmm)) {
        pars <- getME(lmm,"theta")
    } else {
        ## GLMM: requires both random and fixed parameters
        pars <- getME(lmm, c("theta","fixef"))
    }
    return(pars)
} 

re_fit <- function(lmm_input) {
  lmm_output <- update(lmm_input,
                       start = get_pars(lmm_input))
  
  return(lmm_output)
}

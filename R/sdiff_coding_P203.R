sdif_coding_P203 <- function(df) {
  df %<>%
    mutate(
      Type_C = ifelse(Type == "intact", -.5, ifelse(Type == "scrambled", .5, NaN)),
      Cate_C = ifelse(Category == "face", -.5, ifelse(Category == "house", .5, NaN)),
      Dura_C = ifelse(Duration == 17, -.5, ifelse(Duration == 200, .5, NaN)),
      
      Type_Cate = Type_C * Cate_C,
      Type_Dura = Type_C * Dura_C,
      Cate_Dura = Cate_C * Dura_C,
      
      Type_Cate_Dura = Type_Cate * Dura_C,
    )
  
  contrasts(df$Type) <- MASS::contr.sdif(nlevels(df$Type)) 
  contrasts(df$Category) <- MASS::contr.sdif(nlevels(df$Category)) 
  contrasts(df$Duration) <- MASS::contr.sdif(nlevels(df$Duration)) 
  
  return(df)
}


sdif_coding_P203_erp <- function(df) {
  df %<>% 
    sdif_coding_P203() %>% 
    
    mutate(
      Hemi_C = ifelse(Hemisphere %in% c("left", "Left"), -.5, ifelse(Hemisphere %in% c("right", "Right"), .5, NaN)),
      
      Type_Hemi = Type_C * Hemi_C,
      Cate_Hemi = Cate_C * Hemi_C,
      Dura_Hemi = Dura_C * Hemi_C,
      
      Type_Cate_Hemi = Type_C * Cate_C * Hemi_C,
      Type_Dura_Hemi = Type_C * Dura_C * Hemi_C,
      Cate_Dura_Hemi = Cate_C * Dura_C * Hemi_C,
      
      Type_Cate_Dura_Hemi = Type_C * Cate_C * Dura_C * Hemi_C,
    )
  
  contrasts(df$Hemisphere) <- MASS::contr.sdif(nlevels(df$Hemisphere)) 
  
  return(df)
}

sdif_coding_E204_erp <- function(df) {
  df %<>%
    sdif_coding_P203_erp() %>% 
    mutate(
      Resp_C = ifelse(Response == 0, -0.5, ifelse(Response == 1, 0.5, NaN)),
      
      Type_Resp = Type_C * Resp_C,
      Cate_Resp = Cate_C * Resp_C,
      Dura_Resp = Dura_C * Resp_C,
      Hemi_Resp = Hemi_C * Resp_C,
      
      Type_Cate_Resp = Type_C * Cate_C * Resp_C,
      Type_Dura_Resp = Type_C * Dura_C * Resp_C,
      Cate_Dura_Resp = Cate_C * Dura_C * Resp_C,
      Type_Hemi_Resp = Type_C * Hemi_C * Resp_C,
      Cate_Hemi_Resp = Cate_C * Hemi_C * Resp_C,
      Dura_Hemi_Resp = Dura_C * Hemi_C * Resp_C,
      
      Type_Cate_Dura_Resp = Type_C * Cate_C * Dura_C * Resp_C,
      Type_Cate_Hemi_Resp = Type_C * Cate_C * Hemi_C * Resp_C,
      Type_Hemi_Dura_Resp = Type_C * Hemi_C * Dura_C * Resp_C,
      Hemi_Cate_Dura_Resp = Hemi_C * Cate_C * Dura_C * Resp_C,
      
      Type_Cate_Dura_Hemi_Resp = Type_C * Cate_C * Dura_C * Hemi_C * Resp_C
    )
  contrasts(df$Response) <- MASS::contr.sdif(nlevels(df$Response)) 
  
  return(df)
}



sdif_coding_E205_erp <- function(df) {
  
  DuraConf.levels <- c("17_guess", "17_low", "17_high", "200_high")
  
  df %<>%
    sdif_coding_P203_erp() %>%
    
    mutate(
      ConLG_C = ifelse(Confidence == DuraConf.levels[1], -0.75, 0.25), # low - guess (17)
      ConHL_C = ifelse(Confidence %in% DuraConf.levels[1:2], -0.5, 0.5), # guess - low (17)
      Con2H_C = ifelse(Confidence == DuraConf.levels[4], 0.75, -0.25), # 200_high - 17_guess

      Cate_ConLH = Cate_C * ConLG_C,
      Hemi_ConLH = Hemi_C * ConLG_C,

      Cate_Hemi_ConLH = Cate_C * Hemi_C * ConLG_C,

      Cate_ConGL = Cate_C * ConHL_C,
      Hemi_ConGL = Hemi_C * ConHL_C,
      
      Cate_Hemi_ConGL = Cate_C * Hemi_C * ConHL_C,
      
      Cate_Con2G = Cate_C * Con2H_C,
      Hemi_Con2G = Hemi_C * Con2H_C,
      
      Cate_Hemi_Con2G = Cate_C * Hemi_C * Con2H_C
    )
  
  df$DuraConf <- factor(df$DuraConf, DuraConf.levels) # reorder the levels
  contrasts(df$DuraConf) <- MASS::contr.sdif(nlevels(df$DuraConf))

  return(df)
}


sdif_coding_E205_erp_conf <- function(df) {
  
  confidence.levels <- c("guess", "low", "high")
  DuraBlock.levels <- c("17_1", "17_2", "200_2")
  
  df %<>%
    sdif_coding_P203_erp() %>%
    
    mutate(
      ConLH_C = ifelse(Confidence == confidence.levels[1], -0.6666667, 0.3333333), # low - high
      ConGL_C = ifelse(Confidence == confidence.levels[3], 0.6666667, -0.3333333), # guess - low
      
      Cate_ConLH = Cate_C * ConLH_C,
      Hemi_ConLH = Hemi_C * ConLH_C,
      
      Cate_Hemi_ConLH = Cate_C * Hemi_C * ConLH_C,
      
      Cate_ConGL = Cate_C * ConGL_C,
      Hemi_ConGL = Hemi_C * ConGL_C,
      
      Cate_Hemi_ConGL = Cate_C * Hemi_C * ConGL_C, 
      
      Confidence = as.factor(Confidence),
      
      
      Block21_C = ifelse(DuraBlock == DuraBlock.levels[1], -0.6666667, 0.3333333), # low - high
      Block22_C = ifelse(DuraBlock == DuraBlock.levels[3], 0.6666667, -0.3333333),
      
      Cate_ConLH = Cate_C * Block21_C,
      Hemi_ConLH = Hemi_C * Block21_C,
      
      Cate_Hemi_ConLH = Cate_C * Hemi_C * Block21_C,
      
      Cate_ConGL = Cate_C * Block22_C,
      Hemi_ConGL = Hemi_C * Block22_C,
      
      Cate_Hemi_ConGL = Cate_C * Hemi_C * Block22_C, 
    )
  
  df$Confidence <- factor(df$Confidence, confidence.levels) # reorder the levels
  contrasts(df$Confidence) <- MASS::contr.sdif(nlevels(df$Confidence))
  
  df$DuraBlock <- factor(df$DuraBlock, DuraBlock.levels)
  contrasts(df$DuraBlock) <- MASS::contr.sdif(nlevels(df$DuraBlock))
  
  return(df)
}
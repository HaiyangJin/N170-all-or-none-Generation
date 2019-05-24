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
      
      Resp_C = ifelse(urResponse == "RES1", -0.5, ifelse(urResponse == "RES0", 0.5, NaN)),
      
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
  
  contrasts(df$Hemisphere) <- MASS::contr.sdif(nlevels(df$Hemisphere)) 
  contrasts(df$urResponse) <- MASS::contr.sdif(nlevels(df$urResponse)) 
  
  return(df)
}
dummy_coding_P203 <- function(df) {
  df %<>%
    mutate(
      Type_C = if_else(Type == "intact", 0, if_else(Type == "scrambled", 1, NaN)),
      Cate_C = if_else(Category == "face", 0, if_else(Category == "house", 1, NaN)),
      Dura_C = if_else(Duration == "17", 0, if_else(Duration == "200", 1, NaN)),
      
      Type_Cate = Type_C * Cate_C,
      Type_Dura = Type_C * Dura_C,
      Cate_Dura = Cate_C * Dura_C,
      
      Type_Cate_Dura = Type_C * Cate_C * Dura_C
    )
  return(df)
}



dummy_coding_P203_erp <- function(df) {
  df %<>%
    dummy_coding_P203() %>% 
    mutate(
      Hemi_C = if_else(Hemisphere == "Left", 0, if_else(Hemisphere == "Right", 1, NaN)),
      
      Type_Hemi = Type_C * Hemi_C,
      Cate_Hemi = Cate_C * Hemi_C,
      Dura_Hemi = Dura_C * Hemi_C,

      Type_Cate_Hemi = Type_C * Cate_C * Hemi_C,
      Type_Dura_Hemi = Type_C * Dura_C * Hemi_C,
      Cate_Dura_Hemi = Cate_C * Dura_C * Hemi_C,
      
      Type_Cate_Dura_Hemi = Type_C * Cate_C * Dura_C * Hemi_C,
      
      Resp_C = if_else(Response == 0, 0, if_else(Resp == 1, 1, NaN)),

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
  return(df)
}
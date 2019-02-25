dummy_coding_P203 <- function(df) {
  df %<>%
    mutate(
      Type_D = if_else(Type == "normal", 0, if_else(Type == "scrambled", 1, NaN)),
      Cate_D = if_else(Category == "face", 0, if_else(Category == "house", 1, NaN)),
      Dura_D = if_else(Duration == "17", 0, if_else(Duration == "200", 1, NaN)),
      
      Type_Cate = Type_D * Cate_D,
      Type_Dura = Type_D * Dura_D,
      Cate_Dura = Cate_D * Dura_D,
      
      Type_Cate_Dura = Type_D * Cate_D * Dura_D
    )
  return(df)
}



dummy_coding_P203_erp <- function(df) {
  df %<>%
    dummy_coding_P203() %>% 
    mutate(
      Hemi_D = if_else(Hemisphere == "Left", 0, if_else(Hemisphere == "Right", 1, NaN)),
      
      Type_Hemi = Type_D * Hemi_D,
      Cate_Hemi = Cate_D * Hemi_D,
      Dura_Hemi = Dura_D * Hemi_D,

      Type_Cate_Hemi = Type_D * Cate_D * Hemi_D,
      Type_Dura_Hemi = Type_D * Dura_D * Hemi_D,
      Cate_Dura_Hemi = Cate_D * Dura_D * Hemi_D,
      
      Type_Cate_Dura_Hemi = Type_D * Cate_D * Dura_D * Hemi_D,
      
      ACC_D = if_else(ACC == "correct", 0, if_else(ACC == "incorrect", 1, NaN)),

      Type_ACC = Type_D * ACC_D,
      Cate_ACC = Cate_D * ACC_D,
      Dura_ACC = Dura_D * ACC_D,
      Hemi_ACC = Hemi_D * ACC_D,
      
      Type_Cate_ACC = Type_D * Cate_D * ACC_D,
      Type_Dura_ACC = Type_D * Dura_D * ACC_D,
      Cate_Dura_ACC = Cate_D * Dura_D * ACC_D,
      Type_Hemi_ACC = Type_D * Hemi_D * ACC_D,
      Cate_Hemi_ACC = Cate_D * Hemi_D * ACC_D,
      Dura_Hemi_ACC = Dura_D * Hemi_D * ACC_D,
      
      Type_Cate_Dura_ACC = Type_D * Cate_D * Dura_D * ACC_D,
      Type_Cate_Hemi_ACC = Type_D * Cate_D * Hemi_D * ACC_D,
      Type_Hemi_Dura_ACC = Type_D * Hemi_D * Dura_D * ACC_D,
      Hemi_Cate_Dura_ACC = Hemi_D * Cate_D * Dura_D * ACC_D,

      Type_Cate_Dura_Hemi_ACC = Type_D * Cate_D * Dura_D * Hemi_D * ACC_D
      
    )
  return(df)
}
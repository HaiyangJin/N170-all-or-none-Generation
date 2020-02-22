tmpfn <- "E205-N170-resp"
# tmpfn <- "E205-resp"  # 552


res_value = 350
res_rela = 90
w = 650/res_rela*res_value
h = 532/res_rela*res_value

# h = 400/res_rela*res_value


png(file= paste0(tmpfn, ".png") ,width=w,height=h, res = res_value)

#plot
n170.conf.LinePlot

dev.off()


pro Oimage
e = ENVI()
fname = 'D:\Deep_frustrating\sharpening_results\20161031_Pleiades_花蓮_97_ms_sharpening.tiff'
im =e.OpenRaster(fname)
View = e.GetView()

Layer = View.CreateLayer(im)

End
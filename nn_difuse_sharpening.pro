Pro NN_Difuse_sharpening
os = Python.import('os')
; Start the application
e = ENVI()

; Open low-resolution raster and high-resolution raster input files
highResFile = Filepath('qb_boulder_pan', Subdir=['data'], $
  Root_Dir=e.Root_Dir)
highResRaster = e.OpenRaster('D:\Deep_frustrating\pan\20161030_pleiades_苗栗_97_pan\20161030_pleiades_苗栗_97_pan.tif')
lowResFile = Filepath('qb_boulder_msi', Subdir=['data'], $
  Root_Dir=e.Root_Dir)
lowResRaster = e.OpenRaster('D:\Deep_frustrating\ms\20161030_pleiades_苗栗_97_ms\20161030_pleiades_苗栗_97_ms.tif')
 
; Get the NNDiffuse pan-sharpening task from the catalog of ENVITasks
Task = ENVITask('NNDiffusePanSharpening')
 
; Define the inputs
Task.INPUT_LOW_RESOLUTION_RASTER = lowResRaster
Task.INPUT_HIGH_RESOLUTION_RASTER = highResRaster
 
; Run the task
Task.Execute

; Create a temporary output file
;export the result
exportTask = ENVITask('ExportRasterToTiff')
exportTask.INPUT_RASTER = Task.OUTPUT_RASTER
exportTask.OUTPUT_Raster_URI = 'D:\Deep_frustrating\bacheap\20161030_pleiades_苗栗_97_ms_sharpening.tiff'
exportTask.Execute
print, 'done'
End
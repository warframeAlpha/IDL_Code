Pro Maskk
;This program is used to apply mask with multiple images(Batch processing)
;Remember open IDL with new ENVI to ensure this program can work.
; Start the application
e = ENVI()
; locate the target folder
os = Python.import('os')
flist = os.listdir('E:\農地清查影像\2019資料')
vectorFile = 'E:\農地清查影像\山坡地農業區\山坡地農業區.shp'
vector = e.OpenVector(vectorFile)

for f =0, python.len(flist)-1 do begin
  if flist[f].endswith('sharpening') then begin
    fname = python.str('E:\農地清查影像\2019資料\'+python.str(flist[f]))
    print, fname
    Output_fname = python.str('E:\農地清查影像\2019資料\masked_pan_sharpening_results\'+python.str(flist[f])+'masked')
    Raster = e.OpenRaster(fname)
    Task = ENVITask('VectorMaskRaster')
    Task.DATA_IGNORE_VALUE = 65535
    Task.INPUT_MASK_VECTOR = Vector
    Task.INPUT_RASTER = Raster
    Task.OUTPUT_RASTER_URI = Output_fname
    Task.Execute

  endif
endfor
print, 'done'
End
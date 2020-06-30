Pro Build_Label
e = ENVI()
os = Python.import('os')
flist = os.listdir('影像+shp的資料夾')

;Convert vectors to ROI
for i =0, python.len(flist)-1 do begin
  if flist[i].endswith('.shp') then begin
    vname = python.str('影像+shp的資料夾\'+python.str(flist[i]))
    vectorr = e.Openvector(vname)
    Task = ENVITASK(VectorRecordToROI)
    Task.INPUT_VECTOR = Vectorr
    OUTPUT_ROI_URI = python.str('要存新ROI的位置\'+python.str(flist[i]).replace('.shp','ROI.xml'))
    Task.Execute
  endif
endfor
print,'Finishing converting vectors to ROI'
;ROI_list = os.listdir('ROI的資料夾')
; Build Label Raster
for j =0, python.len(flist)-1 do begin
  if flist[j].endswith('.hdr') then begin
    img_name = python.str('影像的資料夾\'+python.str(flist[j]))
    print, img_name
    Raster = e.OpenRaster(img_name)
    ROI_name = python.str('ROI的資料夾'+python.str(flist[j]).replace('.hdr','ROI.xml'))
    ROI = e.OpenROI(ROI_name)
    Task = ENVITask('BuildLabelRasterFromROI')
    Task.INPUT_RASTER = Raster
    Task.INPUT_ROI = ROI
    Task.CLASS_NAMES = ['Building']
    Task.OUTPUT_RASTER_URI = '要存Raster的資料夾\'+python.str(flist[j]).replace('.hdr','Label_Raster')
    Task.Execute
  endif
endfor
print,'done'
End
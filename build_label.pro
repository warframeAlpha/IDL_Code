Pro Build_Label
e = ENVI()
os = Python.import('os')
flist = os.listdir('D:\Deep_frustrating\subset_2')

;Convert vectors to ROI
for i =0, python.len(flist)-1 do begin
  if flist[i].endswith('.shp') then begin
    vname = python.str(flist[i])
    vpath = python.str('D:\Deep_frustrating\subset_2\'+vname)
    print, vpath
    vectorr = e.Openvector(vpath)
    Task = ENVITASK('VectorRecordsToROI')
    Task.INPUT_VECTOR = Vectorr
    output_name = python.str('D:\Deep_frustrating\for_ROI\'+vname.replace('.shp','ROI.xml'))
    Task.OUTPUT_ROI_URI =output_name
    print, output_name
    Task.Execute
  endif
endfor
print,'Finishing converting vectors to ROI'
;ROI_list = os.listdir('ROI的資料夾')
; Build Label Raster
for j =0, python.len(flist)-1 do begin
  if flist[j].endswith('.tif') then begin
    img_path = python.str('D:\Deep_frustrating\subset_2\'+python.str(flist[j]))
    print, img_path
    Raster = e.OpenRaster(img_path)
    img_name = python.str(flist[j])
    ROI_name = python.str('D:\Deep_frustrating\for_ROI\'+img_name.replace('.tif','ROI.xml'))
    ROI = e.OpenROI(ROI_name)
    Task = ENVITask('BuildLabelRasterFromROI')
    Task.INPUT_RASTER = Raster
    Task.INPUT_ROI = ROI
    Task.CLASS_NAMES = ['Building']
    Task.OUTPUT_RASTER_URI = 'D:\Deep_frustrating\Label_Raster\'+img_name.replace('.tif','Label_Raster')
    Task.Execute
  endif
endfor
print,'done'
End
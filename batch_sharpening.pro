pro batch_SmoothVector
; all the to-be smoothed files are called final.shp
; set envi
e = ENVI()

; find folders
os = Python.import('os')
folders = os.listdir('Upper folder')
for i = 0, python.len(folders)-1 do begin
  filee = 'Upper folder' +folders[i]+'final.shp' 
  print, filee
  Vector = e.OpenVector(filee)
  ; Get the task from the catalog of ENVITasks
  Task = ENVITask('SmoothVector')
 
  ; Select task inputs
  Task.INPUT_VECTOR = Vector
  Task.SMOOTH_FACTOR = 14. ; key in the SMOOTH_FACTOR
  
  ; Run the task
  Task.OUTPUT_VECTOR_URI = ''Upper folder' +folders[i]+'final_smoothed.shp' 
  Task.Execute
endfor
print, 'done'

End
 
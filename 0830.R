pkg=install.packages()
pkg
.libPaths()
data(package="datasets")

getRecatangleArea = function(w,h){
  area = w*h
  return(area)
}
# CCLM_EC-EARTH 3h data script to call matlab function to cut out ecotron pixel from netcdf file
# Inne Vanderkelen  16/03/2018



 # call matlab function for precipitation (add single quotations to transform variable name to string)
   matlab -nodesktop -nodisplay -r  extr_ecotr_hist

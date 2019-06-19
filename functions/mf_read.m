% Function to read in data from Maastricht from ECA&D website

function [date, var] = mf_read(stat_name, var_name)

filename = strcat(var_name,stat_name); 

fileID = fopen(filename);
C = textscan(fileID,'%f %f %f %f','Delimiter', ',', 'headerLines',20, 'EmptyValue', -9999);
fclose(fileID);

date = C{2}; 
var = C{3}; 

var(find(var==-9999))= NaN; 
var = var/10; 

end 

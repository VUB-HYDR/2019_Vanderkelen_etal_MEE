% -----------------------------------------------------------------------
% Function to insert NaN in row


function newarray = mf_insertNa(array, position1, position2)
if position2>0
    
length_newarray = length(array)+2; 
else 
    length_newarray = length(array)+1; 

end

newarray = NaN(length_newarray,1);  

    
    newarray(1:position1-1) = array(1:position1-1); 
           
    if position2 >0 
       newarray(position1+1: position2-1) = array(position1:position2-2); 
       newarray(position2+1:length(array)+2) = array(position2-1:length(array));

    else
       newarray(position1+1:length(array)+1) = array(position1:length(array));

    end   
    newarray = newarray'; 
end


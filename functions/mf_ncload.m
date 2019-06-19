% ------------------------------------------------------------------------
% function to read all available nc files from EUR11 CORDEX for defined variable
% 
% Inne Vanderkelen 20/04/2018


function [lat lon VAR] = mf_ncload(var_name,institute,RCM,GCM,run)

   
        if strcmp(run,'eval')
            
            % define file name
            filename = cell2mat(strcat(var_name,'_ecotron_',institute, '-',...
            RCM, '_day_',run,'.nc')); 
   
        elseif strcmp(run,'hist')
            
             % define file name
            filename = cell2mat(strcat(var_name,'_ecotron_',GCM, '-',...
            institute, '-',RCM, '_day_',run,'.nc'));            
            
        elseif strcmp(run,'rcp85')
            
            % define file name
            filename = cell2mat(strcat(var_name,'_ecotron_',GCM, '-',...
                institute, '-', RCM, '_day_',run,'.nc')); 
        end
        
        % check if file is there
        file_exist = exist(filename,'file'); 
 
        % if file is there
        if file_exist == 2
            
            % read variable 
            lat = rot90(ncread(filename, 'lat')); % latitude [° N] (axis: Y)
            lon = rot90(ncread(filename, 'lon')); % longitude [° E] (axis: X)
            VAR =       ncread(filename,var_name); 
        
        
            
            % check variable dimensions and tread accordingly
            [nx ny nz nt] = size(VAR);
            if     numel(size(VAR)) == 2
                
                VAR = rot90(VAR); 
                
            elseif numel(size(VAR)) == 3
                
                VARr = NaN(ny,nx,nz);
                
                for i=1:size(VAR,3)
                    
                    VARr(:,:,i) = rot90(VAR(:,:,i));
                end
                
                VAR = VARr;
                
            elseif numel(size(VAR)) == 4
                
                VAR = permute(VAR,[1 2 4 3]);
                
                % check dimensions again after permute command
                if     numel(size(VAR)) == 3    % it was a 'fake' fourth dimension (e.g. U10,V10)
                    VARr = NaN(ny,nx,nz);
                    
                    for i=1:size(VAR,3)
                        
                        VARr(:,:,i) = rot90(VAR(:,:,i));
                        
                    end
                    
                    VAR = VARr;
                    
                elseif numel(size(VAR)) == 4    % it was a real fourth dimension (e.g. QV_hm)
                    % undo permute (result: vertical: 3th, time: 4th)
                    VAR = permute(VAR,[1 2 4 3]);
                    VARr = NaN(ny,nx,nz,nt);
                    
                    for i=1:size(VAR,3)
                        
                        for j=1:size(VAR,4)
                            
                            VARr(:,:,i,j) = rot90(VAR(:,:,i,j));
                        end
                    end
                    
                    VAR = VARr;
                end
            end
            
            

        % if file is not there send out warning
        else
            disp(strcat(filename,' does not exist'));
            lat= 0; lon =0; VAR = 0; 
        end



end
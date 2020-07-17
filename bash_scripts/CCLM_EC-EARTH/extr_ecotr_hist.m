% ----------------------------------------------------------------------
% Script to extract variable at ecotron location from 3h data

% clean up

clear all 

% loop over all variables
%VARs = [{'rsds'},{'psl'},{'rlds'},{'huss'},{'hfls'},{'hfss'},{'sfcWind'},{'tas'}];
VARs = [{'hfss'}];


years = 1950:2005; 

for i = 1:length(years)
    YEARs{i} = num2str(years(i)); 
end


for i = 1:length(VARs)
    for j = 1:length(YEARs)
        
        if strcmp(VARs{i},'tas') ||strcmp(VARs{i},'sfcWind') || strcmp(VARs{i},'psl') || strcmp(VARs{i},'huss')
            filename = strcat('/gpfs/projects/climate/data/dataset/cordex/EUR-11/historical/3hr/',VARs{i},'/',VARs{i},'_EUR-11_EC-EARTH_historical_r12i1p1_CCLM4-8-17_v1_3hr_',YEARs{j},'010100-',YEARs{j},'123121.nc'); 
        else
            filename = strcat('/gpfs/projects/climate/data/dataset/cordex/EUR-11/historical/3hr/',VARs{i},'/',VARs{i},'_EUR-11_EC-EARTH_historical_r12i1p1_CCLM4-8-17_v1_3hr_',YEARs{j},'010100-',num2str(str2num(YEARs{j})+1),'010100.nc'); 
        end
        
        VAR =       ncread(filename,VARs{i}); 
        
                    [nx ny nz nt] = size(VAR);

            if     numel(size(VAR)) == 2
                
                VAR = rot90(VAR); 
                
            elseif numel(size(VAR)) == 3
                
                VARr = NaN(ny,nx,nz);
                
                for t=1:size(VAR,3)
                    
                    VARr(:,:,t) = rot90(VAR(:,:,t));
                end
                
                VAR = VARr;
                
            elseif numel(size(VAR)) == 4
                
                VAR = permute(VAR,[1 2 4 3]);
                
                % check dimensions again after permute command
                if     numel(size(VAR)) == 3    % it was a 'fake' fourth dimension (e.g. U10,V10)
                    VARr = NaN(ny,nx,nz);
                    
                    for t=1:size(VAR,3)
                        
                        VARr(:,:,t) = rot90(VAR(:,:,t));
                        
                    end
                    
                    VAR = VARr;
                    
                elseif numel(size(VAR)) == 4    % it was a real fourth dimension (e.g. QV_hm)
                    % undo permute (result: vertical: 3th, time: 4th)
                    VAR = permute(VAR,[1 2 4 3]);
                    VARr = NaN(ny,nx,nz,nt);
                    
                    for t=1:size(VAR,3)
                        
                        for k=1:size(VAR,4)
                            
                            VARr(:,:,t,k) = rot90(VAR(:,:,t,k));
                        end
                    end
                    
                    VAR = VARr;
                end
             end
             
        clear VARr
        
        % cut out 
        varT= VAR(191,189,:); 
        var(:) = varT(1,1,:); 
        
        
        clear VAR varT
        
        
        % save variable for one year
        savename = strcat('/gpfs/work/vsc10055/ecotron/data_processed/CCLM_EC-EARTH_3h/historical/',VARs{i},'/',VARs{i},'_ecotron_EC-EARTH_CCLM4-8-17_3hr_',YEARs{j},'.mat'); 
        save(savename,'var')     
        
        
        % save variable for all years
        if j == 1
            var_all = var'; 
        else
            var_all = [var_all; var'];
        end
        
        clear var
        

        
    end
    
    savename_all = strcat('/gpfs/work/vsc10055/ecotron/data_processed/CCLM_EC-EARTH_3h/historical/',VARs{i},'_ecotron_EC-EARTH_CCLM4-8-17_3hr_1950-2005.mat');
    save(savename_all,'var_all')
    
end

% ------------------------------------------------------------------------
% Main script of the Vanderkelen et al (2019) paper 



% flags

flags.eval = 0;               % do evaluation of reanalysis
flags.hist = 0;               % do GCM downscaling evaluation
flags.rcp85 = 1;              % do analysis on future projections
flags.forcing = 0;            % do analysis on simulation serving as ecotron forcing
flags.plotting = 1;           % do plotting

% initialisation 
addpath(genpath('C:\Users\ivand\Downloads\Documents\ecotrons\scripts\2019_Vanderkelen_etal_BG\')); 



% evaluation of reanalysis downscalings
if flags.eval == 1
    
    % load data and calculate scores
    main_eval

   
    if flags.plotting == 1
    
        % fig 5
        plot_rank_paper 

        % fig 4
        plot_seas_cycle
        
        % fig A2
        calc_plot_corr_seas; 
 
    end
    
end


% evaluation of reanalysis downscalings
if flags.hist == 1
    
    % load data and calculate scores
    main_hist

   
    if flags.plotting == 1
        
        % fig 6
        %plot_rank_hist_paper; 

        % fig A1   
        plot_seas_cycle_hist; % plot seasonal cycle
        
        % fig A3
        calc_plot_corr_seas_hist; 

    end
    
end


% analysis on future projection

if flags.rcp85 == 1
    
    main_rcp85
    
    if flags.plotting == 1
        
        % fig 8, A4, A5, A6, A7, A8
        plot_rcp_anomalies; 

    end
    
end
    

% other plots 
if flags.forcing ~= 1;

    if flags.plotting==1

       % fig 3
       plot_statdata;

       % fig 7
       plot_rank_physval_paper;

    end
end


% CCLM-EC-EARTH: determination and extraction of ecotron periods

if flags.forcing ==1 
    
    main_forcing; 
  
    if flags.plotting == 1
    
        % fig 1  
        plot_GMT_conc;

        % fig 9
        plot_ectr_perd_anom;

        % figs 10 and 11
        plot_ecotron_gradient;
    
    end
end




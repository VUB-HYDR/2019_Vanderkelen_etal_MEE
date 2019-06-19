% ------------------------------------------------------------------------
% Function to calcualte correlation bias between two variables and
% observations of the variables

function [corr_var cb corr_obs]= mf_calc_corr(var1,obs1, var2, obs2)


    % observations
    corr_obs = spear(obs2,obs1);

    % variable
    for i = 1:size(var1,2)

        corr_var(i) = spear(var2(:,i),var1(:,i));
    end

    % bias

    cb = corr_var - corr_obs; 

end
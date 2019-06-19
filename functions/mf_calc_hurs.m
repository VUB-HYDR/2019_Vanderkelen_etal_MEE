% ------------------------------------------------------------------------
% function to calculate the relative humidity based on the specific
% humidity and temperature

function [RH] = mf_calc_hurs(q,T,p)

ms_inicon;

e = (p.*q)./0.622; 
es = 611.*exp(17.67.*(T-T0)./(T-29.65)); % hPa
RH = 100*(e./es); 
RH(find(RH>1000))=100;

end

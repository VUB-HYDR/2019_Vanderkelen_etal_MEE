function x=isleap(varargin)
% ISLEAP True for leap year.
%     ISLEAP(Year) returns 1 if Year is a leap year and 0 otherwise.
%     ISLEAP is only set for gregorian calendar, so Year >= 1583
% 
% Syntax: 	ISLEAP(YEAR)
%      
%     Inputs:
%           YEAR - Year of interest (default = current year). 
%           You can input a vector of years.
%     Outputs:
%           Logical vector.
% 
%      Example: 
% 
%           Calling on Matlab the function: isleap
% 
%           Answer is: 0
% 
% 
%           Calling on Matlab the function: x=isleap([2007 2008])
% 
%           Answer is:
%           x = 0 1
% 
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo-edta@poste.it
%           Modified after Simon Jan suggestions
% To cite this file, this would be an appropriate format:
% Cardillo G. (2007) Isleap: a simple routine to test if a year is leap.
% http://www.mathworks.com/matlabcentral/fileexchange/14172

%Input Error handling
p = inputParser;
addOptional(p,'Y',year(datetime('now')),@(x) validateattributes(x,{'numeric'},{'row','real','finite','integer','nonnan','positive','>',1582}))
parse(p,varargin{:});

% The Gregorian calendar has 97 leap years every 400 years: 
% Every year divisible by 4 is a leap year. 
% However, every year divisible by 100 is not a leap year. 
% However, every year divisible by 400 is a leap year after all. 
% So, 1700, 1800, 1900, 2100, and 2200 are not leap years, 
% but 1600, 2000, and 2400 are leap years.
x = ~mod(p.Results.Y, 4) & (mod(p.Results.Y, 100) | ~mod(p.Results.Y, 400)); 

function [r,t,p]=spear(x,y)
%Syntax: [r,t,p]=spear(x,y)
%__________________________
%
% Spearman's rank correalation coefficient.
%
% r is the Spearman's rank correlation coefficient.
% t is the t-ratio of r.
% p is the corresponding p-value.
% x is the first data series (column).
% y is the second data series, a matrix which may contain one or multiple
%     columns.
%
%
% Reference:
% Press W. H., Teukolsky S. A., Vetterling W. T., Flannery B. P.(1996):
% Numerical Recipes in C, Cambridge University Press. Page 641.
%
%
% Example:
% x = [1 2 3 3 3]';
% y = [1 2 2 4 3; rand(1,5)]';
% [r,t,p] = spear(x,y)
%
%
% Products Required:
% Statistics Toolbox
%
% Alexandros Leontitsis
% Department of Education
% University of Ioannina
% 45110- Dourouti
% Ioannina
% Greece
% 
% University e-mail: me00743@cc.uoi.gr
% Lifetime e-mail: leoaleq@yahoo.com
% Homepage: http://www.geocities.com/CapeCanaveral/Lab/1421
% 
% 3 Feb 2002.


% x and y must have equal number of rows
if size(x,1)~=size(y,1)
    error('x and y must have equal number of rows.');
end


% Find the data length
N = length(x);

% Get the ranks of x
R = crank(x)';

for i=1:size(y,2)
    
    % Get the ranks of y
    S = crank(y(:,i))';
    
    % Calculate the correlation coefficient
    r(i) = 1-6*sum((R-S).^2)/N/(N^2-1);
    
end

% Calculate the t statistic
if r == 1 | r == -1
    t = r*inf;
else
    t=r.*sqrt((N-2)./(1-r.^2));
end







function r=crank(x)
%Syntax: r=crank(x)
%__________________
%
% Assigns ranks on a data series x. 
%
% r is the vector of the ranks
% x is the data series. It must be sorted.
%
%
% Reference:
% Press W. H., Teukolsky S. A., Vetterling W. T., Flannery B. P.(1996):
% Numerical Recipes in C, Cambridge University Press. Page 642.
%
%
% Alexandros Leontitsis
% Department of Education
% University of Ioannina
% 45110- Dourouti
% Ioannina
% Greece
% 
% University e-mail: me00743@cc.uoi.gr
% Lifetime e-mail: leoaleq@yahoo.com
% Homepage: http://www.geocities.com/CapeCanaveral/Lab/1421
% 
% 3 Feb 2002.


u = unique(x);
[xs,z1] = sort(x);
[z1,z2] = sort(z1);
r = (1:length(x))';
r=r(z2);

for i=1:length(u)
    
    s=find(u(i)==x);
    
    r(s,1) = mean(r(s));
    
end



function p = tcdf(x,v,uflag)

%TCDF   Student's T cumulative distribution function (cdf).

%   P = TCDF(X,V) computes the cdf for Student's T distribution

%   with V degrees of freedom, at the values in X.

%

%   The size of P is the common size of X and V. A scalar input

%   functions as a constant matrix of the same size as the other input.

%

%   P = TCDF(X,V,'upper') computes the upper tail probability of the

%   Student's T distribution with V degrees of freedom, at the values in X.

%

%   See also TINV, TPDF, TRND, TSTAT, CDF.

%   References:

%      [1] M. Abramowitz and I. A. Stegun, "Handbook of Mathematical

%      Functions", Government Printing Office, 1964, 26.7.

%      [2] L. Devroye, "Non-Uniform Random Variate Generation",

%      Springer-Verlag, 1986

%      [3] E. Kreyszig, "Introductory Mathematical Statistics",

%      John Wiley, 1970, Section 10.3, pages 144-146.

%   Copyright 1993-2014 The MathWorks, Inc.

 

normcutoff = 1e7;

if nargin < 2,

    error(message('stats:tcdf:TooFewInputs'));

end

[errorcode,x,v] = distchck(2,x,v);

if errorcode > 0

    error(message('stats:tcdf:InputSizeMismatch'));

end

if nargin>2

    % Compute upper tail

    if ~strcmpi(uflag,'upper')

        error(message('stats:cdf:UpperTailProblem'));

    end

    x = -x;

    uflag = [];

end

% Initialize P.

p = NaN(size(x),'like',internal.stats.dominantType(x,v)); % single if p or v is

nans = (isnan(x) | ~(0<v)); %  v==NaN ==> (0<v)==false

cauchy = (v == 1);

normal = (v > normcutoff);

% General case: first compute F(-|x|) < .5, the lower tail.

%

% See Abramowitz and Stegun, formulas and 26.7.1/26.5.27 and 26.5.2

general = ~(cauchy | normal | nans);

xsq = x.^2;

% For small v, form v/(v+x^2) to maintain precision

t = (v < xsq) & general;

if any(t(:))

    p(t) = betainc(v(t) ./ (v(t) + xsq(t)), v(t)/2, 0.5, 'lower') / 2;

end

% For large v, form x^2/(v+x^2) to maintain precision

t = (v >= xsq) & general;

if any(t(:))

    p(t) = betainc(xsq(t) ./ (v(t) + xsq(t)), 0.5, v(t)/2, 'upper') / 2;

end

% For x > 0, F(x) = 1 - F(-|x|).

xpos = (x > 0);

p(xpos) = 1 - p(xpos); % p < .5, cancellation not a problem

% Special case for Cauchy distribution.  See Devroye pages 29 and 450.

% Note that instead of the usual Cauchy formula (atan x)/pi + 0.5,

% we use acot(-x), which is equivalent and avoids roundoff error.

p(cauchy)  = xpos(cauchy) + acot(-x(cauchy))/pi;

 

% Normal Approximation for very large nu.

p(normal) = normcdf(x(normal));

% Make the result exact for the median.

p(x == 0 & ~nans) = 0.5;

 

 

function [errorcode,varargout] = distchck(nparms,varargin)

%DISTCHCK Checks the argument list for the probability functions.

%   Copyright 1993-2014 The MathWorks, Inc.

 

 

errorcode = 0;

varargout = varargin;

if nparms == 1

    return;

end

% Get size of each input, check for scalars, copy to output

scalar = cellfun( @isscalar, varargin );

% Done if all inputs are scalars.  Otherwise fetch their common size.

if (all(scalar)), return; end

n = nparms;

sz = cellfun( @size, varargin, 'UniformOutput', false );

t = sz(~scalar);

size1 = t{1};

% Scalars receive this size.  Other arrays must have the proper size.

for j=1:n

   sizej = sz{j};

   if (scalar(j))

      vj = varargin{j};

      if isnumeric(vj)

         t = zeros(size1,'like',vj);

      else

         t = zeros(size1);

      end

      t(:) = vj;

      varargout{j} = t;

   elseif (~isequal(sizej,size1))

      errorcode = 1;

      return;

   end

end




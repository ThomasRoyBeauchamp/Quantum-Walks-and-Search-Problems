function [location,value] = firstMaximum(vector,precision)
% FIRSTMAXIMUM returns the position and value of the first local maximum in
% vector, where vector is periodically close to zero. 
% Arguments:
%   vector (positve real vector) - vector in which one desires to find the
%                                   first local maximum
%   precision (positive integer) - integer such that the algorithm detects
%                                  points close to zero as those which are
%                                  less than 10^{-precision}.

arguments
    vector double {mustBeVector,mustBePositive,mustBeReal}
    precision double {mustBeInteger,mustBePositive}
end


locs = 1:max(size(vector));

lowValues = [locs(vector<10^(-1*precision)),max(size(vector))];

index = 1;

if size(lowValues,2) == 1
    period = lowValues(end);
else
while lowValues(index)+1 == lowValues(index+1)
    index = index+1;
end

period = lowValues(index+1);
end


location = find(vector == max(vector(1:period)));

value = vector(location);

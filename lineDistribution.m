function distribution = lineDistribution(stateVector)
% LINEDISTRIBUTION Computes the probaility distribution for the position of
% the quantum walk with state as supplied by stateVector
% Arguments:
%   stateVector ((2,:) double) - state of the walk to be converted into a
%   probability distributuion.

arguments
    stateVector (2,:) double
end

distribution = zeros(1,size(stateVector,2));
for k = 1:size(stateVector,2)
    distribution(k) = norm(stateVector(:,k))^2;
end

end

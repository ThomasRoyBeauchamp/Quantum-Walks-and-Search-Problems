function distribution = planeDistribution(currentState)
% PLANEDISTRIBUTION Takes a state matrix for the walk on the plane and 
% converts it into the corresponding probabiltiy distribution.
% Arguments: 
%   currentState ((4,:,:) double) - the current state of the quantum walk
%   on a plane 


arguments
    currentState (4,:,:) double
end

numberOfStates = size(currentState,2);


distribution = zeros(numberOfStates,numberOfStates);

for k = 1:numberOfStates
    for l = 1:numberOfStates
        distribution(k,l) = norm(currentState(:,k,l))^2;
    end
end

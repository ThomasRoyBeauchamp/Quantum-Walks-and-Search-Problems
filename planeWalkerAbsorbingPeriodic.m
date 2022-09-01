function [distributions,absorbingState] = planeWalkerAbsorbingPeriodic(absorbingState,timesToReport,initialState,coin)
% PLANEWALKERABSORBINGPERIOIC Simulation of a quantum walk on Z_N x Z_M
% with periodic boundary conditions and a singele absorbing state 
% Arguments:
%   Absorbing State ((1,2) double) - the state at which the walk is
%   absorbed. By default a random point with coordinates in [0,101].
%   timesToReport ((1,:) non-negative integers) - times which the
%   distrubtion of the walk should be outputted through
%   distributions. By default set to 1000
%   initial state ((4,:,:) double) - matrix containing the details of the
%   state of the quantum walk. The four components of the first dimension
%   correspond to the Up, Right, Left, Down components of the coin/chiral
%   state, and the second and third dimension give positon. By default set
%   to the uniform superposition over Z_101 x Z_101
%   coin ((4,4) double) - the matix describing the coin operator for the
%   walk. By default, the Hadamard coin. 


arguments
    absorbingState (1,2) double = [randi(101),randi(101)];
    timesToReport (1,:) double {mustBeInteger} = 1000;
    initialState (4,:,:) double = ones(4,101,101)/(2*101)
    coin (4,4) double = hadamard(4)/2
    
    
end

tic


xDimension = size(initialState,2);
yDimension = size(initialState,3);

%% Evolver

numberOfTimes = size(timesToReport,2);

distributions = zeros(xDimension,yDimension,numberOfTimes);


currentState = orthogonalGridEvolverAbsorbingPeriodic(initialState,timesToReport(1),coin,absorbingState);
distributions(:,:,1) = planeDistribution(currentState);

for n = 2:numberOfTimes
    currentState = orthogonalGridEvolverAbsorbingPeriodic(currentState,timesToReport(n)-timesToReport(n-1),coin,absorbingState);
    distributions(:,:,n) = planeDistribution(currentState);
end

if toc>100
toc
end













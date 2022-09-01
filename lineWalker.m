function [distributions, states] = lineWalker(timesToReport,coinParameters,initialState)
%LINEWALKER Simulates a quantum walk on the line.
% Arguments:
%   timesToReport ((1,:) non-negative integers) - times for which to output the
%   distribution and state of the walk.
%   coinParameters = [phi,theta] where the coin is 
%                    [cos(phi)e^{i*theta}, sin(phi); sin(phi), -cos(phi)e^{-i*theta}]
%   initialState ((1,3) double) = [a b theta] such that the walk starts in
%                                 initial state (a|R> + b e^{i theta}|L>)|0>

arguments
    timesToReport (1,:) double {mustBeInteger,mustBeNonnegative} = 100
    coinParameters (1,2) double {mustBeReal} = [pi/4,0]
    initialState (1,3) double {mustBeReal} = [1,0,0]
    
end

tic

c = cos(coinParameters(1));
s = sin(coinParameters(1));
T = exp(1i*coinParameters(2));

P = [c*T,s;0 0];
Q = [ 0 0;s,-c*T^(-1)];

maxState = max(timesToReport);

numberOfStates = 2*maxState+1;

zeroPosition = maxState+1;

currentState = zeros(2,numberOfStates);

currentState(1,zeroPosition) = initialState(1);
currentState(2,zeroPosition) = initialState(2)*exp(1i * initialState(3));

currentState(:,zeroPosition) = currentState(:,zeroPosition)/norm(currentState(:,zeroPosition));

%% Evolving The Walk

numberOfTimes = size(timesToReport,2);

distributions = zeros(numberOfStates,numberOfTimes);
states = zeros(2,numberOfStates,numberOfTimes);

currentState = lineWalkEvolver(currentState,P,Q,timesToReport(1));
distributions(:,1) = lineDistribution(currentState);
states(:,:,1) = currentState;

for n = 2:numberOfTimes
    currentState = lineWalkEvolver(currentState,P,Q,timesToReport(n)-timesToReport(n-1));
    distributions(:,n) = lineDistribution(currentState);
    states(:,:,n) = currentState;
end




toc




























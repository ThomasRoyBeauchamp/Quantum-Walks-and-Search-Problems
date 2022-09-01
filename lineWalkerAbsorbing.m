function [pAbsorb,distributions, states] = lineWalkerAbsorbing(barrierDistance,timesToReport,coinParameters,initialState)
%LINEWALKERABSORBING Simulates a quantum walk on the line with an absorbing
%boundary (barrierDistance) to the left of the origin
% Arguments:
%   barrierDistance (positive integer) - distance to the left of the origin
%   of the absorbing barrier. 
%   timesToReport ((1,:) non-negative integers) - times for which to output the
%   distribution and state of the walk.
%   coinParameters = [phi,theta] where the coin is 
%                    [cos(phi)e^{i*theta}, sin(phi); sin(phi), -cos(phi)e^{-i*theta}]
%   initialState ((1,3) double) = [a b theta] such that the walk starts in
%                                 initial state (a|R> + b e^{i theta}|L>)|0>

arguments
    barrierDistance (1,1) double {mustBeInteger,mustBePositive} = 1
    timesToReport (1,:) double {mustBeInteger,mustBeNonnegative} = 10000
    coinParameters (1,2) double {mustBeReal} = [pi/4,0]
    initialState (1,3) double {mustBeReal} = [1,0,0]
end

tic

fprintf("Boundary at: -%u, number of time steps: %u ... ",barrierDistance,max(timesToReport));

c = cos(coinParameters(1));
s = sin(coinParameters(1));
T = exp(1i*coinParameters(2));

P = [c*T,s;0 0];
Q = [ 0 0;s,-c*T^(-1)];

maxState = max(timesToReport);

numberOfStates = barrierDistance + maxState+1;

zeroPosition = barrierDistance+1;

currentState = zeros(2,numberOfStates);

currentState(1,zeroPosition) = initialState(1);
currentState(2,zeroPosition) = initialState(2)*exp(1i * initialState(3));

currentState(:,zeroPosition) = currentState(:,zeroPosition)/norm(currentState(:,zeroPosition));

%% Evolving The Walk

numberOfTimes = size(timesToReport,2);

distributions = zeros(numberOfStates,numberOfTimes);
states = zeros(2,numberOfStates,numberOfTimes);
pAbsorb = zeros(1,numberOfTimes);

currentState = lineWalkEvolverAbsorbing(currentState,P,Q,timesToReport(1));
distributions(:,1) = lineDistribution(currentState);
states(:,:,1) = currentState;
pAbsorb(1) = 1-sum(distributions(:,1));

for n = 2:numberOfTimes
    currentState = lineWalkEvolverAbsorbing(currentState,P,Q,timesToReport(n)-timesToReport(n-1));
    distributions(:,n) = lineDistribution(currentState);
    states(:,:,n) = currentState;
    pAbsorb(n) = 1-sum(distributions(:,n));
    distributions(1,n) = pAbsorb(n);
end




fprintf("Time to compute: %.5f seconds\n",toc)

if toc>180
    F = fopen("/Users/thomasbeauchamp/Documents/Durham/Dissertation/Code/Notifications/lineWalkerAbsorbing.txt",'w');
    fclose(F);


end
end






























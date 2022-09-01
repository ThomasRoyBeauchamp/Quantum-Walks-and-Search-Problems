function [distributions,maxP,timeStepsToMax,targetDistribution] = TulsiControlledSearch(N,delta,maxTime,target)
%TULSICONTROLLEDSEARCH Simulation of Tulsi's 2008 algorithm for spacial search
%  Simulation of Tulsi's algorithm for spacial search. The arguments are as
%   follows:
%   N (positive integer) - Side length of the square region of Z^2 the walk
%   take place on. Set to 101 by default
%   delta (real scalar) - Value of delta in the defintion of X_delta =
%   [cos (delta) sin(delta); -sin(delta) cos(delta)] for the algorithm. Set
%   to acos(1/sqrt(log(N^2))) by default.
%   maxTime (non-negative integer) -  amount of time to evolve the walk for.
%   Set to 1000 by default
%   target ((2,1) double) - the marked state which the algorithm is wanting
%   to find. By default this is set to [40,80]


arguments
    N double {mustBeScalarOrEmpty,mustBeInteger,mustBePositive} = 101
    delta double  {mustBeReal,mustBeScalarOrEmpty} = acos(1/sqrt(log(N^2)))
    maxTime double {mustBeNonnegativem mustBeScalarOrEmpty,mustBeInteger} = 1000;
    target (2,1) {mustBeInteger} = [40,80];
end


controlledState = zeros(2,4,N,N);
controlledState(2,:,:,:) = 1/(2*N); %Starts in uniform superposition with control quibit set to |1>. 

tic

progBar = waitbar(0);

Xdelta = [cos(delta) sin(delta); -sin(delta) cos(delta)];
ZBar = [-1 0; 0 1];

distributions = zeros(N,N,maxTime);

targetDistribution = zeros(1,maxTime);


for t = 1:maxTime

    controlledState = pagemtimes(Xdelta,controlledState);

    controlledState(2,:,target(1),target(2)) = -controlledState(2,:,target(1),target(2));

    controlledState = pagemtimes(Xdelta',controlledState);

    controlledState(2,:,:,:) = OrthogonalGridEvolverPeriodic(reshape(controlledState(2,:,:,:),4,N,N),1,groverCoin(),1);

    controlledState = pagemtimes(ZBar,controlledState);


    distributions(:,:,t) = planeDistribution(reshape(controlledState(1,:,:,:),4,N,N)) + planeDistribution(reshape(controlledState(2,:,:,:),4,N,N));

    targetDistribution(t) = distributions(target(1),target(2),t);

    timeCheck = toc;
    waitbar(t/maxTime,progBar,sprintf('Computing Distribution... %i/%i ( %s || %s )',t,maxTime,datestr(seconds(timeCheck),'MM:SS'),datestr(seconds(timeCheck/t*(maxTime-t)),'MM:SS')))

end

[timeStepsToMax,maxP] = firstMaximum(reshape(distributions(target(1),target(2),:),1,maxTime),5);


close(progBar)

end
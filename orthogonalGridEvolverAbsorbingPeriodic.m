function [walkState] = orthogonalGridEvolverAbsorbingPeriodic(walkState,timeSteps,coin,target)
% ORTHOGONALGRIDEVOLVERABSORBINGPERIODIC Evolves the quantum walk on the
% orthogonal grid with an absorbing state for the specified number of time 
% steps. 
% Arguments:
%   walkState ((4,:,:) double) - current state of the quantum walk
%   timeSteps ((1,1) double) - number of time steps to evolve for
%   coin ((4,4) double) - matrix representation of the coin operator for
%                         the quantum walk
%   target ((1,2) positive integers) - position of the absorbing state.

arguments
    walkState (4,:,:) double
    timeSteps (1,1) double {mustBeInteger}
    coin (4,4) double
    target (1,2) double {mustBeInteger,mustBePositive}
end

tic

if timeSteps >500
    progressBar = waitbar(0);
end

for t = 1:timeSteps
    walkState = OrthogonalGridEvolverPeriodic(walkState,1,coin,0);
    walkState(:,target(1),target(2)) = 0;

    if timeSteps>500
        timeCheck = toc;
        waitbar(t/timeSteps,progressBar,sprintf('Computing Distribution... %i/%i ( %s || %s )',t,timeSteps,datestr(seconds(timeCheck),'MM:SS'),datestr(seconds(timeCheck/t*(timeSteps-t)),'MM:SS')))
    end
end

if timeSteps>500
    close(progressBar)
end
if toc>100
    fprintf('Elapsed time is %s\n', datestr(seconds(toc),'MM:SS'))
end
end
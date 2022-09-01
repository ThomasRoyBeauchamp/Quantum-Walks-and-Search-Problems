function currentState = OrthogonalGridEvolverPeriodic(currentState,timeSteps,C0,flipFlop)
% ORTHOGONALGRIDEVOLVERPERIODIC Handles updating the state of the quantum
% walk on an orthogonal grid for the specified number of timesteps.
% Arguments:
%   currentState ((4,:,:) double) - current state of the quantum walk
%   timeSteps (integer) - number of steps to evolve the walk for (can be
%   zero)
%   C0 ((4,4) double) - The coin operator used for the walk.
%   flipFlop (logical) Whether to use the natural (false/0) or flipflop (true/1) shift
%   operators, which preserve the chirality of the walk or invert the
%   chirality of the walk respectively. By default set to true/1


arguments
    currentState (4,:,:) double
    timeSteps double {mustBeScalarOrEmpty,mustBeInteger,mustBeNonnegative}
    C0 (4,4) double
    flipFlop logical = true
end



    gridSizeY = size(currentState,3);

    doProgressBar = (timeSteps>500);

    if doProgressBar
        progressBar = waitbar(0);
    end

    for t = 1:timeSteps
    

        coinEvolvedState = pagemtimes(C0,currentState);
        
            
        currentState(:,1,1) = [coinEvolvedState(4,2,1);
                            coinEvolvedState(3,1,2);
                            coinEvolvedState(2,1,end);
                            coinEvolvedState(1,end,1)];
    
        currentState(:,2:end-1,1) = [coinEvolvedState(4,3:end,1);
                                 coinEvolvedState(3,2:end-1,2);
                                 coinEvolvedState(2,2:end-1,end);
                                 coinEvolvedState(1,1:end-2,1)];

        currentState(:,end,1) = [coinEvolvedState(4,1,1);
                             coinEvolvedState(3,end,2);
                             coinEvolvedState(2,end,end);
                             coinEvolvedState(1,end-1,1)];
    
        for y = 2:gridSizeY-1
    
            currentState(:,1,y) = [coinEvolvedState(4,2,y);
                               coinEvolvedState(3,1,y+1);
                               coinEvolvedState(2,1,y-1);
                               coinEvolvedState(1,end,y)];
    
            currentState(:,2:end-1,y) = [coinEvolvedState(4,3:end,y);
                                     coinEvolvedState(3,2:end-1,y+1);
                                     coinEvolvedState(2,2:end-1,y-1);
                                     coinEvolvedState(1,1:end-2,y)];
    
            currentState(:,end,y) = [coinEvolvedState(4,1,y);
                                 coinEvolvedState(3,end,y+1);
                                 coinEvolvedState(2,end,y-1);
                                 coinEvolvedState(1,end-1,y)];
        end
                          
    
        currentState(:,1,end) = [coinEvolvedState(4,2,end);
                               coinEvolvedState(3,1,1);
                               coinEvolvedState(2,1,end-1);
                               coinEvolvedState(1,end,end)];
    
        currentState(:,2:end-1,end) = [coinEvolvedState(4,3:end,end);
                                 coinEvolvedState(3,2:end-1,1);
                                 coinEvolvedState(2,2:end-1,end-1);
                                 coinEvolvedState(1,1:end-2,end)];
    
        currentState(:,end,end) = [coinEvolvedState(4,1,end);
                             coinEvolvedState(3,end,1);
                             coinEvolvedState(2,end,end-1);
                             coinEvolvedState(1,end-1,end)];
    
        
        if ~flipFlop

            currentState = flipud(currentState);
    
        end

        if doProgressBar
            waitbar(t/timeSteps,progressBar,sprintf('Calculating Distribution... %i/%i',t,timeSteps));
        end
        
   

    end


    if doProgressBar
        close(progressBar)
    end

end

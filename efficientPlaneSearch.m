function [distributions, target] = efficientPlaneSearch(timesToReport,coin0,coin1,initialState,target)
% EFFICIENTPLANESEARCH simulates the algorithm of Ambainis, Kempe and
% Rivosh (2004) on the orthogonal grid with a single marked state. 
% Arguments:
%   timesToReport ((1,:) positive integers) - times at which to output the
%       proabbility distribution for the position of the random walk. By
%       default this is 1000
%   coin0 ((4,4) double) - the main coin for the random walk. By default
%       this is the Grover coin. 
%   coin1 ((4,4) double) - the marking coin for the AKR algorithm. By
%       default this is -I
%   initialState ((4,:,:) double) - matrix descibing the initial state of
%       the quantum walk. The first dimension contains the amplitudes of the
%       four chiralities in the order Up, Right, Left, Down; the second and
%       third give the position on the grid. By default this is the uniform
%       superposition over Z_101 x Z_101 
%   target ((1,2) double) - position of the marked state. By default this
%       a randomly chosen point, which is outputted by 'target'
%   




arguments
    timesToReport (1,:) double {mustBeInteger,mustBeVector} = 1000
    coin0 (4,4) double = groverCoin()
    coin1 (4,4) double = -eye(4)
    initialState (4,:,:) double  = ones(4,101,101)/(2*101)
    target (1,2) double  {mustBePositive} = [randi(101),randi(101)]

end

numberOfTimes = size(timesToReport,2);

gridSizeX = size(initialState,2);
gridSizeY = size(initialState,3);

distributions = zeros(gridSizeX,gridSizeY,numberOfTimes);



currentState = markedCoinOrthogonalGridEvolverPeriodic(initialState,target,timesToReport(1),coin0,coin1,1);


distributions(:,:,1) = planeDistribution(currentState);

for T = 2:numberOfTimes

    currentState = markedCoinOrthogonalGridEvolverPeriodic(currentState,target,timesToReport(T)-timesToReport(T-1),coin0,coin1,1);    
    distributions(:,:,T) = planeDistribution(currentState);
end

end


function currentState = markedCoinOrthogonalGridEvolver(currentState,target,timeSteps,C0,C1,flipFlop)


arguments
    currentState
    target
    timeSteps
    C0
    C1
    flipFlop logical = true
end


    gridSizeX = size(currentState,2);
    gridSizeY = size(currentState,3);

    doProgressBar = (timeSteps>500);

    if doProgressBar
        progressBar = waitbar(0);
    end

    for t = 1:timeSteps
    

        coinEvolvedState = pagemtimes(C0,currentState);
        coinEvolvedState(:,target(1),target(2)) = C1*currentState(:,target(1),target(2));

        
            
        currentState(:,1,1) = [coinEvolvedState(4,2,1);
                            coinEvolvedState(3,1,2);
                            0;
                            0];
    
        currentState(:,2:end-1,1) = [coinEvolvedState(4,3:end,1);
                                 coinEvolvedState(3,2:end-1,2);
                                 zeros(1,gridSizeX-2);
                                 coinEvolvedState(1,1:end-2,1)];

        currentState(:,end,1) = [0;
                             coinEvolvedState(3,end,2);
                             0;
                             coinEvolvedState(1,end-1,1)];
    
        for y = 2:gridSizeY-1
    
            currentState(:,1,y) = [coinEvolvedState(4,2,y);
                               coinEvolvedState(3,1,y+1);
                               coinEvolvedState(2,1,y-1);
                               0];
    
            currentState(:,2:end-1,y) = [coinEvolvedState(4,3:end,y);
                                     coinEvolvedState(3,2:end-1,y+1);
                                     coinEvolvedState(2,2:end-1,y-1);
                                     coinEvolvedState(1,1:end-2,y)];
    
            currentState(:,end,y) = [0;
                                 coinEvolvedState(3,end,y+1);
                                 coinEvolvedState(2,end,y-1);
                                 coinEvolvedState(1,end-1,y)];
        end
                          
    
        currentState(:,1,end) = [coinEvolvedState(4,2,end);
                               0;
                               coinEvolvedState(2,1,end-1);
                               0];
    
        currentState(:,2:end-1,end) = [coinEvolvedState(4,3:end,end);
                                 zeros(1,gridSizeX-2);
                                 coinEvolvedState(2,2:end-1,end-1);
                                 coinEvolvedState(1,1:end-2,end)];
    
        currentState(:,end,end) = [0;
                             0;
                             coinEvolvedState(2,end,end-1);
                             coinEvolvedState(1,end-1,end)];
    
        
        if flipFlop
    
            currentState = currentState/sqrt(sum(abs(currentState(:).^2)));
        else
            currentState = flipup(currentState/sqrt(sum(abs(currentState(:).^2))));
    
        end

        if doProgressBar
            waitbar(t/timeSteps,progressBar,sprintf('Calculating Distribution... %i/%i',t,timeSteps));
        end
        
   

    end


    if doProgressBar
        close(progressBar)
    end

end

function currentState = markedCoinOrthogonalGridEvolverPeriodic(currentState,target,timeSteps,C0,C1,flipFlop)


arguments
    currentState
    target
    timeSteps
    C0
    C1
    flipFlop logical = true
end



    gridSizeY = size(currentState,3);

    doProgressBar = (timeSteps>500);

    if doProgressBar
        progressBar = waitbar(0);
    end

    for t = 1:timeSteps
    

        coinEvolvedState = pagemtimes(C0,currentState);
        coinEvolvedState(:,target(1),target(2)) = C1*currentState(:,target(1),target(2));

        
            
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
    
        
        if flipFlop
    
            currentState = currentState/sqrt(sum(abs(currentState(:).^2)));
        else
            currentState = flipup(currentState/sqrt(sum(abs(currentState(:).^2))));
    
        end

        if doProgressBar
            waitbar(t/timeSteps,progressBar,sprintf('Calculating Distribution... %i/%i',t,timeSteps));
        end
        
   

    end


    if doProgressBar
        close(progressBar)
    end

end




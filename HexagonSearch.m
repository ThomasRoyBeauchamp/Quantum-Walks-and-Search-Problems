function [distributions,dTarget] = HexagonSearch(maxTime,rows,columns)
% HEXAGONSEARCH simulates the quantum walk/Ambainis, Kempe and Rivosh algorithm 
% on a hexagonal grid with a single marked element at a random location.
%  Outputs the distribtuion for the entire graph, as well as the probability
%  to find the walk at the marked step for every time up to maxTime
% Arguments:
%   maxTime (positive integer) - length of time to evolve the walk for
%   rows (positive integer) - number of rows in the hexagonal grid. Must be
%       even to remain on the hexagonal grid, otherwise the periodic conditions
%       will mean the walk will also vist the hexagonal grid with verticies
%       at the mid-points of the rows of the original grid.
%   columns (positive integer) - number of verticies in each row. 

arguments
    maxTime double {mustBeInteger,mustBeReal,mustBePositive,mustBeScalarOrEmpty}
    rows double {mustBeInteger,mustBeReal,mustBePositive,mustBeScalarOrEmpty}
    columns double {mustBeInteger,mustBeReal,mustBePositive,mustBeScalarOrEmpty}
end

rng('default') %For reproducability

 %Number of elements on each row

stateVector = zeros(6,rows,2*columns);



stateVector(:,1:2:end,1:2:end) = 1/sqrt(6*rows*columns);

stateVector(:,2:2:end,2:2:end,:) = 1/sqrt(6*rows*columns);

markedStateRow = randi(rows);

if mod(markedStateRow,2) == 0
    markedStateColumn = 2*randi(columns);
else
    markedStateColumn = 2*randi(columns)-1;
end




Coin0 = 2*1/6*ones(6) - eye(6);

Coin1 = -eye(6);

distributions = zeros(rows,2*columns,maxTime);





%% iterator



for t = 1:maxTime

    coinedState = pagemtimes(Coin0,stateVector);
    coinedState(:,markedStateRow,markedStateColumn) = Coin1*stateVector(:,markedStateRow,markedStateColumn);

    for j = 1:2*columns
        for k = 1:rows


            stateVector(:,k,j) = [coinedState(6,k,indexModulus(j+2,2*columns));
                                  coinedState(5,indexModulus(k-1,rows),indexModulus(j+1,2*columns));
                                  coinedState(4,indexModulus(k-1,rows),indexModulus(j-1,2*columns));
                                  coinedState(3,indexModulus(k+1,rows),indexModulus(j+1,2*columns));
                                  coinedState(2,indexModulus(k+1,rows),indexModulus(j-1,2*columns));
                                  coinedState(1,k,indexModulus(j-2,2*columns))];

        end
    end

    distributions(:,:,t) = hexagonDistribution(stateVector);

end



dTarget = distributions(markedStateRow,markedStateColumn,:);


end




function [distribution] = hexagonDistribution(stateVector)

    distribution = zeros(size(stateVector,2),size(stateVector,3));
    for row = 1:size(stateVector,2)
        for column = 1:size(stateVector,3)
            distribution(row,column) = norm(stateVector(:,row,column))^2;
        end
    end
end












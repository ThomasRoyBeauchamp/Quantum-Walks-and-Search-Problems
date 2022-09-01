function [finalState] = lineWalkEvolver(state,P,Q,timeSteps)

arguments
    state (2,:) double 
    P (2,2) double
    Q (2,2) double
    timeSteps (1,1) double {mustBeInteger}
end

C = P+Q;




for t = 1:timeSteps
%     newState = zeros(size(state));
% 
%     newState(:,1) = Q*state(:,2);
% 
%     N = size(state,2);
%     newState(:,2:N-1) = P*state(:,1:N-2) + Q*state(:,3:N);
%     
%     newState(:,end) = P*state(:,end-1);

    newState = C*state;

    state(1,2:end) = newState(1,1:end-1);
    state(2,1:end-1) = newState(2,2:end);

end

finalState = state;












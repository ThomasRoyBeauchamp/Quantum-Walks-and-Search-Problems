function coin = groverCoin()
% GROVERCOIN returns the matrix form of the Grover coin 2|s><s| - I where 
% |s> is the uniform superposition of 4 states.

coin = 1/2*(ones(4)-2*eye(4));

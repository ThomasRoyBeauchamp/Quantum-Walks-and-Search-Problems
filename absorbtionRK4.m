function p = absorbtionRK4(M,integrationWidth)
% ABSORBTIONRK4 returns the probability for a Hadamard quantum walk
% starting in the state |R>|0> to be absorbed by a boundary at |-M>, by
% numerically integrating the formulae of Bach et al. (2002). using te
% fourth-order Runge-Kutta method
% Arguments:
%   M (positive integer) - distance to the boundary
%   integrationWidth (postive real) - integration width for the RK4
%   algorithm. 

arguments
    M double {mustBeInteger,mustBePositive,mustBeScalarOrEmpty}
    integrationWidth double {mustBePositive, mustBeReal}
end

timeSteps = floor(2*pi/integrationWidth);

reportingIntervals = 10^(floor(log10(timeSteps))-1);

p = 0;

tic
for t = 0:timeSteps

    if mod((timeSteps-t),reportingIntervals)==0
        fprintf('Steps Remaining: %i, time remaining: %0.3f seconds\n',timeSteps-t,(toc/t)*(timeSteps-t))
    end


    k1 = absorbtionIntegrand(M,t*integrationWidth);
    k2 = absorbtionIntegrand(M,t*integrationWidth + integrationWidth/2);
    k3 = absorbtionIntegrand(M,t*integrationWidth+integrationWidth/2);
    k4 = absorbtionIntegrand(M,t*integrationWidth+integrationWidth);

    p = p+(1/6)*(k1+2*k2+2*k3+k4)*integrationWidth;

end

p = p/(2*pi);

toc;

end

function P = absorbtionIntegrand(M,theta)

f = (1+exp(2i*theta) - sqrt(1+exp(4i*theta)))/(sqrt(2)*exp(1i*theta));
g = (1-exp(2i*theta) - sqrt(1+exp(4i*theta)))/(sqrt(2)*exp(1i*theta));

P = abs(f)^2*abs(g)^(2*M-2);
end

%Integral absorbtion probabilities

distances = [1 2 5 10 20 50 100 1000];

pIntegral = [0 0 0 0 0 0 0 0];

integrationWidth = 1e-5;

for k = 1:7
    pIntegral(k) = absorbtionRK4(distances(k),integrationWidth);
end

A = [distances;pIntegral];

fprintf("Boundary Distance: %u --- Absorbtion Probability: %0.4f\n",A)
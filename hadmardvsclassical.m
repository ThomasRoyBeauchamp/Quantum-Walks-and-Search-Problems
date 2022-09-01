%Hadamard Walk vs Classical Walk

d = lineWalker;

figure()

binomialDistributionData = pdf('binomial',0:100,100,0.5);


plot(-100:2:100,binomialDistributionData,'- .',Color=[1,0,0])

hold on


hold on

plot(-100:2:100,d(1:2:end),'-x',Color='black')

xlabel('x')
ylabel('Probability')

%Quantum Hadamard walk distributions

binomialDistributionData = pdf('binomial',0:100,100,0.5);

figure()
tiledlayout(3,1)

d = lineWalker(100,[pi/4,0],[1 0 0]);


nexttile
plot(-100:2:100,binomialDistributionData,'- .',Color=[1,0.5,0.5])
hold on
plot(-100:2:100,d(d~=0),'-x','Color','black')
title('A')
ylabel(sprintf('probability to find\n the walk in state |x>'))
xlabel('x')

nexttile
plot(-100:2:100,binomialDistributionData,'- .',Color=[1,0.5,0.5])
hold on
d = lineWalker(100,[pi/4,0],[0 1 0]);

plot(-100:2:100,d(d~=0),'-x','Color','black')
title('B')
ylabel(sprintf('probability to find\n the walk in state |x>'))
xlabel('x')
nexttile

d = lineWalker(100,[pi/4,0],[1 1 pi/2]);
plot(-100:2:100,binomialDistributionData,'- .',Color=[1,0.5,0.5])
hold on
plot(-100:2:100,d(d~=0),'-x','Color','black')
title('C')
ylabel(sprintf('probability to find\n the walk in state |x>'))
xlabel('x')
ylim([0,0.1])


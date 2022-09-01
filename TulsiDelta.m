%Tulsi Delta Dependence

delta0 = acos(1/(sqrt(log(101^2))));

deltas = 0:delta0/32:pi/2;

maxIndex = size(deltas,2);

maxTime = [500*ones(1,32),2000*ones(1,8),4000];

timeToMaximise = zeros(1,maxIndex);
maximumProbability = zeros(1,maxIndex);


for k = 1:maxIndex

    [~,maximumProbability(k),timeToMaximise(k)] = TulsiControlledSearch(101,(deltas(k)),maxTime(k),[40,80]);
    
    fprintf('%u,',k)

end

fprintf('\n\n')

figure()
tiledlayout(2,1)
nexttile

yyaxis left

plot(deltas,timeToMaximise)
ylabel(sprintf('Time to reach\nfirst maximum'))
xticks(0:pi/16:pi/2)
xticklabels({'0','\pi/16','\pi/8','3\pi/16','\pi/4','5\pi/16','3\pi/8','7\pi/16','\pi/2'})
xlabel('\delta')

yyaxis right

plot(deltas,maximumProbability)
ylabel('pMeasure')

title('A')
nexttile
hold on

plot(deltas,maximumProbability./timeToMaximise)
plot([delta0,delta0],[0,2.5e-3],':',Color='red')
ylim([0,0.0025])

xticks(0:pi/16:pi/2)
xticklabels({'0','\pi/16','\pi/8','3\pi/16','\pi/4','5\pi/16','3\pi/8','7\pi/16','\pi/2'})
xlabel('\delta')
ylabel('pMeasure/Tmax')
ylabel('pMeasure / Tmax')
title('B')




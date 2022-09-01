%HExagon vs AKR

rng('default') %for reproducabilityp

figure()
tiledlayout(2,1)


NHex = 20:10:250;

timeToMaximiseHex = zeros(1,24);
maxProbabilitiesHex = zeros(1,24);

for i = 1:24

    [~,dTarget] = HexagonSearch(500,NHex(i),NHex(i)/2);
    [timeToMaximiseHex(i),maxProbabilitiesHex(i)] = firstMaximum(dTarget(:),5);
end

N = 21:10:180;

firstMaxLocationsAKR = zeros(1,16);
firstMaxValuesAKR = zeros(1,16);

progBar = waitbar(0);

tic

tMax = 500;


for k = 1:16

    [d,t] = efficientPlaneSearch(1:tMax,groverCoin(),-eye(4),ones(4,N(k),N(k))/(2*N(k)),[randi(N(k)),randi(N(k))],1);
    dTarget = d(t(1),t(2),:);
    dTarget = dTarget(:);
    [firstMaxLocationsAKR(k),firstMaxValuesAKR(k)] = firstMaximum(dTarget(:),3);

    timeCheck = toc;
    waitbar(k/16,progBar,sprintf('Computing Distribution... %i/%i ( %s || %s )',k,16,datestr(seconds(timeCheck),'MM:SS'),datestr(seconds(timeCheck/k*(23-k)),'MM:SS')))

end

figure()
tiledlayout(1,2)

nexttile

hold on
plot(N.^2,firstMaxLocationsAKR,'-o')
plot(NHex.^2/2,timeToMaximiseHex,'-x')

xlabel('N')
ylabel('Time to Maximise')
title('A')
legend({'Orthogonal','Hexagonal'})

nexttile

plot(N.^2,firstMaxValuesAKR)
hold on
plot(NHex.^2/2,maxProbabilitiesHex)
xlabel('N')
ylabel(sprintf('Probability to observe\nmarked state'))
title('B')
legend({'Orthogonal','Hexagonal'})














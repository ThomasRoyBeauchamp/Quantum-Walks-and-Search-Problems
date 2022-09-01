%DFT Absorbing

rng('default') %for reproducability

N = 21:2:150;
maxTime = 1000;

correlations = zeros(1,65);
averageIncrementToN2 = zeros(1,65);

progBar = waitbar(0);

for k = 1:65


    initialState = ones(4,N(k),N(k))/(2*N(k));

    distribution = planeWalkerAbsorbingPeriodic([randi(N(k)),randi(N(k))],1:maxTime,initialState,DFTCoin());

    pSurvive = sum(sum(distribution));

    pAbsorb = 1-pSurvive(:);
    


    pAbsorbAve = mean(pAbsorb'./(1:maxTime));

    correlations(k) = corr(pAbsorb,(1:maxTime)');
    averageIncrementToN2(k) = pAbsorbAve/(1/N(k)^2);

    waitbar(k/65,progBar,sprintf('Computing... %i/65',k))


end

close(progBar)
figure()
% tiledlayout(2,1)
% nexttile
% plot(N,averageIncrementToN2);
% nexttile
% plot(N,correlations);


yyaxis left

plot(N.^2,correlations);
ylim([0.995,1])
ylabel('correlation')
yyaxis right
plot(N.^2,averageIncrementToN2);
ylabel('Increment/N')
xlabel('N')

distribution = planeWalkerAbsorbingPeriodic([40,80],1:1000,ones(4,101,101)/(2*101),DFTCoin());
pSurvive = sum(sum(distribution));

    pAbsorb = 1-pSurvive(:);

figure()
plot(1:1000,pAbsorb)
xlabel('t')
ylabel('pAbsorb')



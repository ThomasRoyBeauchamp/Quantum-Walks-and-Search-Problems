%unmarked Coins Diagrams

initialState = 1/(2*101)*ones(4,101,101);
target = [40,80];

[X,Y] = meshgrid(1:101,1:101);

figure()
tiledlayout(1,3);

%nexttile
%title('Starting State')
%planeDistributionPlotter(planeDistribution(initialState),0.1,2,target',1,101,1,101)
%contour(Y,X,planeDistribution(initialState),50)


nexttile

distribution = planeDistribution(orthogonalGridEvolverAbsorbingPeriodic(initialState,1000,hadamard(4)/2,target));

%planeDistributionPlotter(distribution,0.1,2,target',1,101,1,101);
contour(Y,X,distribution,30)
title(sprintf('A. pAbsorb = %0.2e',1-sum(distribution(:))))
hold on
plot(40,80,'o',Color='black')


nexttile

distribution = planeDistribution(orthogonalGridEvolverAbsorbingPeriodic(initialState,1000,DFTCoin(),target));

%planeDistributionPlotter(distribution,0.1,2,target',1,101,1,101);
contour(Y,X,distribution,30)
title(sprintf('B. pAbsorb = %0.2e',1-sum(distribution(:))))
hold on
plot(40,80,'o',Color='black')

nexttile

distribution = planeDistribution(orthogonalGridEvolverAbsorbingPeriodic(initialState,1000,groverCoin(),target));

%planeDistributionPlotter(distribution,0.1,2,target',1,101,1,101);
contour(Y,X,distribution,30)
title(sprintf('C. pAbsorb = %0.2e',1-sum(distribution(:))))
hold on
plot(40,80,'ocp',Color='black')



% nexttile(5,[1,4])
% 
% colourGradient  = [0.5:1/200:1;0.5:-1/200:0;zeros(1,101)];
% 
% colourGradient2 = [0:1/200:0.5;0.5:1/100:1,0:1/100:0.49;0.5:-1/200:0];
% 
% X1 = 0:0.001:0.1;
% X2 = 0.11:0.01:1;
% hold on;
% for k = 1:101
%     plot(X1(k),0,'.',color = colourGradient2(:,k));
% end
% for k = 1:90
%     plot(X2(k),0,'.',color = colourGradient(:,k+11))
% end

% xticklabels({})
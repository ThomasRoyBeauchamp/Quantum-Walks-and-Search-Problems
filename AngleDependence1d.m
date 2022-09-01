% angleDependence 1d walk


phi = 0:pi/128:pi/2;

phiDistributionsMax = zeros(1,65);

for k = 1:65

    d = lineWalker(1000,[phi(k),0]);
    phiDistributionsMax(k) = find(d == max(d),1,'last');

end

figure()
tiledlayout(2,1);
nexttile(2)

plot(phi,(phiDistributionsMax-1001)/1000,'-')
hold on
plot(phi,cos(phi),'x')
xlim([0,pi/2])
xticks(0:pi/16:pi/2)
xticklabels(["0","\pi/16","\pi/8","3\pi/16","\pi/4","5\pi/16","3\pi/8","7\pi/16","\pi/2"])
xlabel('\phi')
ylabel('$x_{Max} / t$',Interpreter='latex')
title('B')
legend({'Simulation','$cos(\phi)$'},Interpreter="latex",Location="northeast")
nexttile(1)
for phi = [pi/8,pi/4,3*pi/8]
    hold on
    d = lineWalker(100,[phi,0]);
    plot(-100:2:100,d(1:2:end),'-x');
end

legend({'\phi = \pi/8','\phi = \pi/4','\phi = 3\pi/8'},Location="northwest")
title('A')
xlabel('x')
ylabel('probability')





theta = [0,pi/4,pi/2];

figure()

for T = 1:3
    hold on
    d = lineWalker(100,[pi/4,theta(T)],[1,1,pi/2]);
    plot(-100:2:100,d(1:2:end))
end

xlabel('x')
ylabel('Probability')
legend({'\theta = 0','\theta = \pi/4','\theta = \pi/2'},Location='northwest')


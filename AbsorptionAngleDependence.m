%Absorption Vs Angle


increment = pi/128;

T = 0:increment:pi/2;
N = (pi/2)/(increment)+1;

boundaries = [1:1:10,20:10:100];

pAbsorbT = zeros(19,N);
maxAngle = zeros(1,19);

figure()
tiledlayout(2,1)
nexttile
startTime = datetime('now');


for k = 1:19

    for t = 1:N
        pAbsorbT(k,t) = lineWalkerAbsorbing(boundaries(k),100*boundaries(k),T(t));
    end

    maxAngle(k) = T(pAbsorbT(k,:) == max(pAbsorbT(k,:)));
    hold on
    if boundaries(k) == 1 || boundaries(k) == 2|| boundaries(k) == 5|| boundaries(k) == 10|| boundaries(k) == 50|| boundaries(k) == 100
    plot(T,pAbsorbT(k,:));
    end

end



xticks(0:pi/16:pi/2)
xticklabels(["0","\pi/16","\pi/8","3\pi/16","\pi/4","5\pi/16","3\pi/8","7\pi/16","\pi/2"])
xlabel('\phi')
ylabel('$P(Absorbed)$',Interpreter='latex')
legend({'1','2','5','10','50','100'},"Orientation","horizontal",Location="northwest",NumColumns=3)
title('A')

nexttile(2)

plot(boundaries,maxAngle,Color='black');
xlabel('M')
ylabel('\phi')
ylim([3*pi/16,pi/2])
yticks(3*pi/16:pi/16:pi/2)
yticklabels(["3\pi/16","\pi/4","5\pi/16","3\pi/8","7\pi/16","\pi/2"])
title('B')

fprintf("Total Elapsed time: %s\n",between(startTime,datetime('now')))
notify("AbsorbtionVsAngle")



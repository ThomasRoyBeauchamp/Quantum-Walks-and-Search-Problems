%Line walker survivial against boundary as a proportion of time steps
%evolved. 

maxMultiplier = 200;

threshhold1 = zeros(1,19);
threshhold2 = zeros(1,19);

limit = zeros(1,19);

boundary = [1:10, 20:10:100];

pSurvivial = zeros(19,maxMultiplier);

figure(1)
hold on
for k = 1:19
    limit(k) = absorbtionRK4(boundary(k),1e-5);

    pSurvivial(k,:) = lineWalkerAbsorbing(boundary(k),boundary(k):boundary(k):maxMultiplier*boundary(k));
    plot(1:1:maxMultiplier,limit(k) - pSurvivial(k,:))

    threshhold1(k) = find(limit(k)-pSurvivial(k,:)<1e-4,1,"first");
    threshhold2(k) = find(limit(k)-pSurvivial(k,:)<1e-5,1,"first");

end


legend(string(boundary))
figure()
plot([boundary;boundary]',[threshhold1;threshhold2]')
legend(["1e-4" "1e-5"])
xlabel("$M$",'interpreter','latex')
ylabel("$k$",'interpreter','latex')

figure()

tiledlayout(3,1)
nexttile
plot([boundary;boundary]',[threshhold1;threshhold2]')
ylim([20 210])
legend(["1e-4" "1e-5"])
title("A")
xlabel("$M$",'interpreter','latex')
ylabel("$k$",'interpreter','latex')

nexttile
hold on
for k = 1:19
    plot(1:1:maxMultiplier,limit(k) - pSurvivial(k,:))
end

ylim([0 2e-4])
xlim([0 100])
title("B")
xlabel("$M$",'interpreter','latex')
ylabel("$|p_t - p_\infty|$",'interpreter','latex')

nexttile
hold on
for k = 1:19
    plot(1:1:maxMultiplier,limit(k) - pSurvivial(k,:))
end

ylim([0 2e-5])
xlim([100 200])
title("C")
xlabel("$M$",'interpreter','latex')
ylabel("$|p_t - p_\infty|$",'interpreter','latex')











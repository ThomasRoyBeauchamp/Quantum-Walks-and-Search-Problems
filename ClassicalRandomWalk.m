%Classical Random Walk

rng('default');

p = 1/2;


timeSteps = 200;

repeats = 1000;

results = zeros(1,repeats);

figureNumber = 1;


for r = 1:repeats

    for t = 1:timeSteps

        if unifrnd(0,1)<p
            results(r) = results(r)+1;
        else
            results(r) = results(r)-1;
        end

    end

end


close(figureNumber)
f = figure(figureNumber);
tiledlayout(2,1)
nexttile

Y = pdf('binomial',0:200,200,p);

plot(-200:2:200,Y,':','color','red','linewidth',4)

hold on

histogram(results,-timeSteps:timeSteps,'Normalization','pdf')



xlabel('$S_{200}$',Interpreter='latex')
ylabel('probability')
title('A')

xlim([-200,200]);
ylim(ylim);



p = 0.3;

results = zeros(1,repeats);





for r = 1:repeats

    for t = 1:timeSteps

        if unifrnd(0,1)<p
            results(r) = results(r)+1;
        else
            results(r) = results(r)-1;
        end

    end

end
    

nexttile
Y = pdf('binomial',0:200,200,p);

plot(-200:2:200,Y,':','color','red','linewidth',4)
hold on
histogram(results,-timeSteps:timeSteps,'Normalization','pdf')
xlim([-200,200]);
xlabel('$S_{200}$',Interpreter='latex')
ylabel('probability')
title('B')



figure(figureNumber+1);
close(figureNumber+1);
figure(figureNumber+1);

p =0.5

walk = zeros(1,201);
for t = 2:201
    if unifrnd(0,1)<p
        walk(t) = walk(t-1)+1;
    else
        walk(t) = walk(t-1)-1;
    end
end

plot(0:200,walk,'color','black');
hold on
plot([0,200],[0,0],'color','black')
xlabel('$n$',Interpreter='latex')
ylabel('$S_n$',Interpreter='latex')



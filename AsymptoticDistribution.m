%Aysmptotic Distribution Comparison



t = 100;


d = lineWalker(t);

n = (-t:2:t);

alpha = n/t;

filter = -1/sqrt(2)<alpha & alpha<1/sqrt(2);

alpha = alpha(filter);
n = n(filter);

kAlpha = acos(alpha./sqrt(1-alpha.^2));

omegaK = asin(sin(kAlpha)./sqrt(2));

psi = -(omegaK-alpha.*kAlpha);


pRight = 2*(1+alpha)./(pi*(1-alpha).*sqrt(1-2*alpha.^2)*t).*cos(psi*t+pi/4).^2;
pLeft = 2./(pi*sqrt(1-2*alpha.^2)*t).*cos(psi*t+pi/4+kAlpha).^2;


restrictedDistribution = d(1:2:end);
restrictedDistribution = restrictedDistribution(filter);

asympDist = (pLeft+pRight)';

averageDevience(round(t/20)) = mean(restrictedDistribution(2:end-1) - asympDist(2:end-1));


figure()

hold on
plot(-t:2:t,d(1:2:end),'-');


plot(n,pRight+pLeft,'x')




legend({'Simulation','Asymptotic'})
xlabel('Position')
ylabel('Probability')

figure()
pSlow = (1+alpha)./(pi*t*(1-alpha.^2).*sqrt(1-2*alpha.^2));
plot(n,2*pSlow,'--',Color='black')

hold on
plot(-t:2:t,d(1:2:end),'-');
xlabel('Position')
ylabel('Probability')
legend({'pSlow','Simulation'})


% B = 2*alpha./sqrt(1-alpha);
% 
% Delta = B.^2 - 4*(B+1);
% 
% 
% 
% rho = angle(-B + sqrt(Delta));
% 
% theta = angle(B+2+sqrt(Delta));
% 
% omega = alpha.*rho + theta;
% 
% pLeft1 = 2./(pi*sqrt(1-2*alpha.^2)*t).*cos(-omega*t + pi/4 - rho).^2;
% pRight1 = 2*(1+alpha)./(pi*(1-alpha).*sqrt(1-2*alpha.^2)*t).*cos(-omega*t+pi/4).^2;
% 
% plot(n,pLeft1+pRight1);


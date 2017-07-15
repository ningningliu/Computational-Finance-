S0=3480;
K=3225;
r=0.06;
time = (222-1)/252;
n= 221;

ui=zeros(221,1);
for i = 2:1:222
    ui(i-1,:)= log(dt_c1(i,3)/dt_c1(i-1,3));
end
s= sqrt(sum(ui.^2)/(n-1)- sum(ui)^2/(n*(n-1)));
sigma= s*sqrt(252);

% Black-scholes to price call option
d1= (log(S0/K)+(r+sigma^2/2)*(time))/(sigma* sqrt(time));
d2= d1- sigma*sqrt(time);

price_bs= S0*normcdf(d1)-K*exp(-r*(time))*normcdf(d2);

% Binomial lattice model to price call option
N=  30;
c_bl = zeros(N,2);
delta_t = zeros(N,1);
callprice=zeros(N,1);
% abs_diff = zeros(N,1);
T=222/252;
for j =1:1:N
    callprice(j,1)=price_bs;
    c_bl(j,1)=j;
    delta_t(j,:)= T/j;
    [price, lattice] = LatticeEurCall(S0,K,r,T,sigma,j);
    c_bl(j,2) = price;
%     abs_diff(j,:)= abs(c-price);
end
plot(c_bl(:,1),callprice(:,1),'b--','LineWidth',2);hold on;
plot(c_bl(:,1),c_bl(:,2),'r-','LineWidth',1);
xlabel('No. of time steps', 'FontSize',14)
ylabel('Estimated option price','FontSize',14)
title('Black-scholes vs Binomial lattice (European call option)','FontSize',14), hold on;

% 
%     
% 
% 
% 

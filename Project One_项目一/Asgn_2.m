% import data
index = totalReturnsindex(:,31);
asset = totalReturnsindex(:,1:3);
M_t = round(length(asset)/2);
T = length(asset);
%compute expected return and covriance of three stocks
m = mean(asset(1:M_t,:))';
c = cov(asset(1:M_t,:));

%  maximise return without constraints of risk
% wt = linprog(-m,[],[],ones(1,3),1,zeros(3,1))
% gamma = 1;
% risk_tor = gamma/2;
% n=3;
% cvx_begin quiet
% variable weight(n)
%     minimize (weight'*(-m)+ risk_tor* weight'*c*weight)
%     subject to
%         weight'* ones(n,1)== 1;
%         weight' >0 ;
% cvx_end

% Markowitz portfolio
% n=3;
% cvx_begin quiet
% variable weight(n)
%     minimize (weight'*c*weight)
%     subject to
%         weight'* m == 0.4;   
%         weight'* ones(n,1)== 1;
%         weight >= 0;
% cvx_end


% naive strategy
w_naive = [1/3 , 1/3, 1/3]';

% compute sharp ratio
return_mv = asset(M_t+1:T,:)* weight;
return_naive = asset(M_t+1:T,:) * w_naive;
risk_free = 0.025;
sr_mv = (mean(return_mv) - risk_free)/std(return_mv);
sr_naive = (mean(return_naive) - risk_free)/std(return_naive);

    





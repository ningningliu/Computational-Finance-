% cd('/Users/ningning/Documents/MATLAB/cvx')
% cvx_setup

% Q1 (a) %
%
m = [0.1 0.2 0.15]';
C = [0.005 -0.01 0.004 ; -0.01 0.04 -0.002; 0.004 -0.002 0.023];
N = 100;

% Fincial tool box: portfolio object
% generate weights matrix
randnum= rand(N,3);
randnum_norm = repmat(sum(randnum,2),1,3);
w = randnum./randnum_norm;

% expected return 
M = w*m;
% expected covariance
V = w*C*w';
% E-V plot
risk = diag(V);
% plot(M,risk,'X','LineWidth',2);
% xlabel('E - Expected Return','FontSize',14);
% ylabel('V - Variance','FontSize',14);
% title('E-V Space Scatter Plot', 'FontSize',14);

% Q1 (b) %
%
% Efficient Frontier
% p = Portfolio;
% p = setAssetMoments(p,m,C);
% p = setDefaultConstraints(p);
% plotFrontier(p,10);hold on;
% 
% p1 = Portfolio;
% p1 = setAssetMoments(p1,m1,C1);
% p1 = setDefaultConstraints(p1);
% plotFrontier(p1,10);hold on;
% 
% p2 = Portfolio;
% p2 = setAssetMoments(p2,m2,C2);
% p2 = setDefaultConstraints(p2);
% plotFrontier(p2,10);hold on;
% 
% p3 = Portfolio;
% p3 = setAssetMoments(p3,m3,C3);
% p3 = setDefaultConstraints(p3);
% plotFrontier(p3,10);


% % model_1: A1-A2
% m1 = [0.1 0.2]';
% C1 = [0.005 -0.01 ; -0.01 0.04];
% randnum1= rand(N,2);
% randnum_norm1 = repmat(sum(randnum1,2),1,2);
% w1 = randnum1./randnum_norm1;
% M1 = w1*m1;
% V1 = w1*C1*w1';
% risk1 = diag(V1);
% plot(risk1,M1,'rX','LineWidth',2);hold on
% 
% % model_2: A1-A3
% m2 = [0.1 0.15]';
% C2 = [0.005 0.004 ; 0.004 0.023];
% randnum2= rand(N,2);
% randnum_norm2 = repmat(sum(randnum2,2),1,2);
% w2 = randnum2./randnum_norm2;
% M2 = w2*m2;
% V2 = w2*C2*w2';
% risk2 = diag(V2);
% plot(risk2,M2,'bX','LineWidth',2);hold on
% 
% % model_3: A2 -A3
% m3 = [0.2 0.15]';
% C3 = [0.04 -0.002 ; -0.002 0.023];
% randnum3= rand(N,2);
% randnum_norm3 = repmat(sum(randnum3,2),1,2);
% w3 = randnum3./randnum_norm3;
% M3 = w3*m3;
% V3 = w3*C3*w3';
% risk3 = diag(V3);
% plot(risk3,M3,'cX','LineWidth',2);
%

% Q1 (d) % 
%
% Use NaiveMV function
plot(PRisk,PRoR,'bx','LineWidth',2);
xlabel('Variance','FontSize',14);
ylabel('Expected Return','FontSize',14);
title('Efficient Frontier (linprog/quadprog vs cvx)', 'FontSize',14);hold on


% Use CVX package
% 
% n=3;
% cvx_begin quiet
% variable weight(n)
%     minimize (weight'*(-m))
%     subject to
%         weight'* ones(n,1)== 1;
%         weight' >0 ;
% cvx_end

% n=3;
% cvx_begin quiet
% variable weight(n)
%     minimize (weight'*C* weight)
%     subject to
%         weight'* ones(n,1)== 1;
% cvx_end

% Use NaiveMV_cvx function
plot(PRisk_cvx,PRoR_cvx,'r-','LineWidth',2);
xlabel('Variance','FontSize',14);
ylabel('Expected Return','FontSize',14);
% title('Efficient Frontier (NaiveMV_CVX)', 'FontSize',14);














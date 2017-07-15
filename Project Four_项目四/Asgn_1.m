% generate white nosie time series
% set x1 = 1, x2=2, a1=0.01, a2 =-0.2, a3= 0.5, vt = n(0,1);
% initialise inpute
x1 = 1;
x2= 1;
N=1000;
v = normrnd(0,1,1,N);
w = [0.01 -0.2 0.5]';
input= ones(1,3);
output = ones(N,1);
input(1,1)=x1;
input(1,2) = x2;
for i=1:1:N
    output(i,:)= input* w + v(:,i);
    input(1,1)= input(1,2);
    input(1,2)= output(i,:);
end

% time_ser = [x1; x2; output];
% t = 1:1:N+2;
% plot(t,time_ser,'LineWidth',1)
% ylabel('Signal', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('White Noise Time Series', 'FontSize', 16);
% axis([0 1000 -4 4]);

% use least square to estimate parameters
% 
ls_mat = ones(N,3);
for i = 1: 1: N
    ls_mat(i,1)=time_ser(i,:);
    ls_mat(i,2)= time_ser(i+1,:);
end
ls_f= time_ser(3:N+2,:);
[trainInd,valInd,testInd] = dividerand(1000,0.7,0,0.3);

ls_w = ls_mat(trainInd,:)\ls_f(trainInd); % a1= 0.0408, a2 = -0.0858, a3 = 0.4197


ls_error = ls_f(testInd)- ls_mat(testInd,:)*ls_w;

% estimate w using Kalman filtering

% initialise vt, theta, wt
theta = zeros(N,3);
error = zeros(N,1);
theta_error = zeros(N,3);
vt=1;
wt= 0.00001*eye(3);
Ft= eye(3);
theta_t_1_t_1 = [1 1 1]\time_ser(3,:);
% theta_t_1_t_1 = ls_w;

P_t_1_t_1 = 0.01*eye(3);
for i = 1:1:N
    theta_t_t_1 = Ft*theta_t_1_t_1;
    P_t_t_1= Ft * P_t_1_t_1*Ft'+wt;
    zt = time_ser(i+2,:);
    Ht = [time_ser(i:i+1,:)', 1];
    rt= zt-Ht*theta_t_t_1;
    error(i,:) = rt;
    St = Ht*P_t_t_1*Ht'+vt;
    Kt= P_t_t_1*Ht'/St;
    theta_t_t = theta_t_t_1 + Kt*rt;
    the_error =(w - theta_t_t)';
    theta_error (i,:) =the_error ;
    P_t_t= (eye(3) -Kt*Ht)*P_t_t_1;
    theta(i,:)= theta_t_t;
    theta_t_1_t_1=theta_t_t;
    P_t_1_t_1=P_t_t;
end
% get theta [0.0710108866696150,-0.190251053683408,0.456554625071134]
% time = 1:1:N;
% a1 = 0.01 * ones(N,1);
% a2 = -0.2* ones(N,1);
% a3 = 0.5*ones(N,1);
% plot(time,a1,'r--','LineWidth',2);hold on
% plot(time,a2,'b--','LineWidth',2);hold on
% plot(time,a3,'g--','LineWidth',2);hold on
% plot(theta(:,1),'r-');hold on
% plot(theta(:,2),'b-');hold on
% plot(theta(:,3),'g-'); hold on
% ylabel('Signal', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('Kalman Filtering for White Noise Time Series (Wt=0.00001, Vt =1)', 'FontSize', 16);
% 

% Tune process noise and observation noise
% k1 =0.01;
% vt1 = 1;
% theta1 = kl_ws(k1,time_ser,N,vt1);
% plot(time,a1,'r--','LineWidth',2);hold on
% plot(time,a2,'b--','LineWidth',2);hold on
% plot(time,a3,'g--','LineWidth',2);hold on
% plot(theta1(:,1),'r-');hold on
% plot(theta1(:,2),'b-');hold on
% plot(theta1(:,3),'g-'); hold on
% ylabel('Signal', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('Kalman Filtering for White Noise Time Series (Wt=0.01, Vt=1)', 'FontSize', 16);    

% k2 =0.00001;
% vt2 = 10;
% theta2 = kl_ws(k2,time_ser,N, vt2);
% plot(time,a1,'r--','LineWidth',2);hold on
% plot(time,a2,'b--','LineWidth',2);hold on
% plot(time,a3,'g--','LineWidth',2);hold on
% plot(theta2(:,1),'r-');hold on
% plot(theta2(:,2),'b-');hold on
% plot(theta2(:,3),'g-'); hold on
% ylabel('Signal', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('Kalman Filtering for White Noise Time Series (Wt=0.00001, Vt=10)', 'FontSize', 16);    
% axis([0 1000 -0.3 0.6]);

% k3 =0.01;
% vt3 = 10;
% theta3 = kl_ws(k3,time_ser,N, vt3);
% plot(time,a1,'r--','LineWidth',2);hold on
% plot(time,a2,'b--','LineWidth',2);hold on
% plot(time,a3,'g--','LineWidth',2);hold on
% plot(theta3(:,1),'r-');hold on
% plot(theta3(:,2),'b-');hold on
% plot(theta3(:,3),'g-'); hold on
% ylabel('Signal', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('Kalman Filtering for White Noise Time Series (Wt=0.01, Vt=10)', 'FontSize', 16);    


% predication error
% Kalman error 
% plot(error,'k-');
% ylabel('Error (f_t - estimated f_t )', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('Error from Kalman Filtering (Wt=0.00001, Vt =1)', 'FontSize', 16);

% leasquart error 
% iff_est =[diff_c1,diff_c2,diff_c3,diff_c4,diff_c5,diff_p1,diff_p2,diff_p3,diff_p4,diff_p5];
% boxplot(diff_est,'Labels',{'c2925','c3025','c3125','c3225','c3325','p2925','p3025','p3125','p3225','p3325'});
% ylabel('differences of option price', 'FontSize', 14)
% xlabel('options with strike price', 'FontSize', 14)
% title('Difference of estimated option price against true price', 'FontSize', 16);

error_set = [ls_error, error(testInd)];
boxplot(error_set,'Labels', {'Least square solution', 'Kalman filtering'});
ylabel('Predication errors', 'FontSize', 14)
% xlabel('Estimation methods', 'FontSize', 14)
title('Boxplot for Predication Errors', 'FontSize', 16);
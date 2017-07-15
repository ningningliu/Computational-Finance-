% % Load data 
% filename = 'c2925.prn';
% dt_c1 = importdata(filename);
% 
% filename = 'c3025.prn';
% dt_c2 = importdata(filename);
% 
% filename = 'c3125.prn';
% dt_c3 = importdata(filename);
% 
% filename = 'c3225.prn';
% dt_c4 = importdata(filename);
% 
% filename = 'c3325.prn';
% dt_c5 = importdata(filename);
% 
% filename = 'p2925.prn';
% dt_p1 = importdata(filename);
% 
% filename = 'p3025.prn';
% dt_p2 = importdata(filename);
% 
% filename = 'p3125.prn';
% dt_p3 = importdata(filename);
% 
% filename = 'p3225.prn';
% dt_p4 = importdata(filename);
% 
% filename = 'p3325.prn';
% dt_p5 = importdata(filename);

% % 
T= 222;
tau= 252;
win_size = round(T/4);



% dt = dt_c1(:,3);
% K = 2925;
% dt=dt_c2(:,3);
% K= 3025;
% dt=dt_c3(:,3);
% K= 3125;
% dt=dt_c4(:,3);
% K= 3225;
% dt=dt_c5(:,3);
% K= 3325;
% dt = dt_p1(:,3);
% K = 2925;
% dt=dt_p2(:,3);
% K= 3025;
% dt=dt_p3(:,3);
% K= 3125;
% dt=dt_p4(:,3);
% K= 3225;
% dt=dt_p5(:,3);
% K= 3325;


% estimate volatility
%
% for i = win_size+1:1:T
%     j= i-win_size;
%     if j== 1
%         ui_container(1,1)= log(dt(1,:)/dt(1,:));
%         for j=2:1:win_size
%             ui_container(j,1)=log(dt(j,:)/dt(j-1,:));
%         end
%     else
%         for index = 1:1:win_size
%             ui_container(index,1)= log(dt(j+index-1,:)/dt(j+index-2,:));
%         end
%     end
%     vol_est(j,1)= sum(ui_container.^2);
%     vol_est(j,2)= (sum(ui_container))^2;
%     vol_est(j,3) = sqrt(vol_est(j,1)/(n-1)- vol_est(j,2)/(n*(n-1)));
%     vol_est(j,4)= vol_est(j,3)*sqrt(tau);
%    
% end

% 
% 
% % BS pricing for call option 
% for i=1:1:166
%     d1= (log(dt(i+win_size,1)/K)+(r+vol_est(i,4)^2/2)*(1/365))/(vol_est(i,4)*sqrt(1/365));
%     d2= d1- (vol_est(i,4)*sqrt(1/365));
%     price_bs(i,1)= dt(i+win_size,1)* normcdf(d1)- K*exp(-r*1/365)* normcdf(d2);
% end

% diff_c1 = dt_c1(57:222,2)-price_bs;
% diff_c2 = dt_c2(57:222,2)-price_bs;
% diff_c3 = dt_c3(57:222,2)-price_bs;
% diff_c4 = dt_c4(57:222,2)-price_bs;
% diff_c5 = dt_c5(57:222,2)-price_bs;

% BS pricing for put option 
% for i=1:1:166
%     d1= (log(dt(i+win_size,1)/K)+(r+vol_est(i,4)^2/2)*(1/365))/(vol_est(i,4)*sqrt(1/365));
%     d2= d1- (vol_est(i,4)*sqrt(1/365));
%     price_bs(i,1)= K*exp(-r*1/365)* normcdf(-d2)- dt(i+win_size,1)* normcdf(-d1) ;
% end

% diff_p1 = dt_p1(57:222,2)-price_bs;
% diff_p2 = dt_p2(57:222,2)-price_bs;
% diff_p3 = dt_p3(57:222,2)-price_bs;
% diff_p4 = dt_p4(57:222,2)-price_bs;
% diff_p5 = dt_p5(57:222,2)-price_bs;


[vol_est_c1,diff_c1]=bs_call(dt_c1,2925);
[vol_est_c2,diff_c2]=bs_call(dt_c2,3025);
[vol_est_c3,diff_c3]=bs_call(dt_c3,3125);
[vol_est_c4,diff_c4]=bs_call(dt_c4,3225);
[vol_est_c5,diff_c5]=bs_call(dt_c5,3325);
[vol_est_p1,diff_p1]=bs_put(dt_p1,2925);
[vol_est_p2,diff_p2]=bs_put(dt_p2,3025);
[vol_est_p3,diff_p3]=bs_put(dt_p3,3125);
[vol_est_p4,diff_p4]=bs_put(dt_p4,3225);
[vol_est_p5,diff_p5]=bs_put(dt_p5,3325);

diff_est =[diff_c1,diff_c2,diff_c3,diff_c4,diff_c5,diff_p1,diff_p2,diff_p3,diff_p4,diff_p5];
boxplot(diff_est,'Labels',{'c2925','c3025','c3125','c3225','c3325','p2925','p3025','p3125','p3225','p3325'});
ylabel('differences of option price', 'FontSize', 14)
xlabel('options with strike price', 'FontSize', 14)
title('Difference of estimated option price against true price', 'FontSize', 16);


% vol_30_c1= implied(dt_c1,2925);
% vol_30_c2= implied(dt_c2,3025);
% vol_30_c3= implied(dt_c3,3125);
% vol_30_c4= implied(dt_c4,3225);
% vol_30_c5= implied(dt_c5,3325);

% 
x=1:1:30;
plot(x',vol_30_c1(23:52,:),'bo','LineWidth',2);hold on;
plot(x',vol_est_c1(23:52,4),'ro','LineWidth',2);

title('Historical volatility vs Implied volatility','FontSize', 14)
xlabel('ith trading day','FontSize', 14)
ylabel('Volatility','FontSize', 14)

% s = [2925;3025;3125;3225;3325];
% s_v = [s, zeros(5,1)];
% vol_30 = [vol_30_c1,vol_30_c2,vol_30_c3,vol_30_c4,vol_30_c5];
% % choose 2
% i=101;
% s_v(1,2)= vol_30_c1(i,:);
% s_v(2,2)= vol_30_c2(i,:);
% s_v(3,2)= vol_30_c3(i,:);
% s_v(4,2)= vol_30_c4(i,:);
% s_v(5,2)= vol_30_c5(i,:);
% 
% plot(s_v(:,1),s_v(:,2),'mo--','LineWidth',2)
% xlabel('Strick price','FontSize', 14);
% ylabel('Implied volatility','FontSize', 14);
% title('Implied volatility with different Strick price','FontSize', 14);
% % axis([0 4000 0 1]); grid on;
% 

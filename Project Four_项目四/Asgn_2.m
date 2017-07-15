% % Load data 
% filename = 'SP500.csv';
% spindex =csvread(filename);
% armodel= ar(spindex(:,1),3);
% f_prd= predict(armodel,spindex(:,1));
% ob_error = spindex(:,1)-f_prd;
% f_var = var(ob_error); % observation noise = 2808
% 
% [m n]= size(spindex);
% M = m- 5;
% % initialise vt, theta, wt
% theta = zeros(M,5);
% error = zeros(M,1);
% vt=f_var;
% wt= 0.00001*eye(5);
% Ft= eye(5);
% theta_t_1_t_1 = spindex(1:5,:)'\spindex(6,:);
% % 
% P_t_1_t_1 = 0.001*eye(5);
% for i = 1:1:M
%     theta_t_t_1 = Ft*theta_t_1_t_1;
%     P_t_t_1= Ft * P_t_1_t_1*Ft'+wt;
%     zt = spindex(i+5,:);
%     Ht = [spindex(i:i+3,:)', 1];
%     rt= zt-Ht*theta_t_t_1;
%     error(i,:) = rt;
%     St = Ht*P_t_t_1*Ht'+vt;
%     Kt= P_t_t_1*Ht'/St;
%     theta_t_t = theta_t_t_1 + Kt*rt;
%     P_t_t= (eye(5) -Kt*Ht)*P_t_t_1;
%     theta(i,:)= theta_t_t;
%     theta_t_1_t_1=theta_t_t;
%     P_t_1_t_1=P_t_t;
% end
% 
% 
% time = 1:1:M;
% plot(time,theta(:,1),'b-','LineWidth',1.5);hold on;
% plot(time,theta(:,2),'r-','LineWidth',1.5);hold on;
% plot(time,theta(:,3),'g-','LineWidth',1.5);hold on;
% plot(time,theta(:,4),'k-','LineWidth',1);hold on;
% % plot(time,theta(:,5),'c-','LineWidth',1);hold on;
% ylabel('Theta at t', 'FontSize', 14)
% xlabel('Time step t', 'FontSize', 14)
% title('Kalman Filtering for S&P 500 (Wt=0.0001)', 'FontSize', 16);

% % model residual error , 7 varialbes 
% filename = 'CORPROFIT.csv';
% corprofit =csvread(filename);
% 
% filename = 'EMRATE.csv';
% emrate =csvread(filename);
% 
% filename = 'INCOME.csv';
% income =csvread(filename);
% 
% filename = 'OIL.csv';
% oil =csvread(filename);
% 
% filename = 'PER.csv';
% per =csvread(filename);
% 
% filename = 'PMI.csv';
% pmi =csvread(filename);
% 
% filename = 'POP.csv';
% ppl =csvread(filename);

% % use lag = 1, total variables n = 7*1=7, window size = 5, 6th is
% % predication

% cd('/Users/ningning/Documents/MATLAB/cvx')
% cvx_setup

% n=7;
% R = [corprofit(5,:),emrate(5,:),income(5,:),oil(5,:),per(5,:),pmi(5,:),ppl(5,:)];
% y = error(2,:);
% tau = 0.01;
% cvx_begin quiet
% variable w_sparse(n)
%     minimize (norm(y-R*w_sparse) + tau* norm(w_sparse,1))
% cvx_end

% n=7;
% w1= zeros(M,n);
% for i = 1:1:M
%     j=i+4
%     R = [corprofit(j,:),emrate(j,:),income(j,:),oil(j,:),per(j,:),pmi(j,:),ppl(j,:)];
%     y= error(i,:);
%     tau=0.0001;
% cvx_begin quiet
%     variable w_sparse(n)
%     minimize (norm(y-R*w_sparse) + tau* norm(w_sparse,1))
% cvx_end   
% w1(i,:)= w_sparse;
% end 

coff_nzero = zeros(1,n);
for i =1:1:n
    coff_nzero (1,i)=numel(find(abs(w1(:,i))>0.0000001));
end

% c = categorical({'CORP PROFIT','UNEMPLOYED','INCOME','OIL','PER','PMI','POPULATION'});
% bar(c,coff_nzero)

% bar(coff_nzero,'b');
% set(gca,'XTickLabel', {'CORP PROFIT', 'UNEMPLOYED', 'INCOME', 'OIL', 'PER','PMI','POPULATION'});
% ylabel('Selected Frequency', 'FontSize', 14)
% xlabel('Variables', 'FontSize', 14)
% title('Selected Variables Frequency (lag=1)', 'FontSize', 16);    

% % use lag = 3, 6=5,4,3
n=21;
w2= zeros(M,n);
R= zeros(1,n);
for i=1:1:M
    j=i+4
    k=i+2;
  
    R = [corprofit(k:j,:)',emrate(k:j,:)',income(k:j,:)',oil(k:j,:)',per(k:j,:)',pmi(k:j,:)',ppl(k:j,:)'];
    y= error(i,:);
    tau=0.0001;
cvx_begin quiet
    variable w_sparse(n)
    minimize (norm(y-R*w_sparse) + tau* norm(w_sparse,1))
cvx_end   
w2(i,:)= w_sparse;
end 

coff_nzero2 = zeros(1,n);
for i =1:1:n
    coff_nzero2(1,i)=numel(find(abs(w2(:,i))>0.0000001));
end

coff_sum2 = zeros(1,7);
j=1;
for i=1:3:21
    coff_sum2(1,j)= sum(coff_nzero2(1,i:i+2));
    j=j+1;
end

% bar(coff_sum2,'r');
% set(gca,'XTickLabel', {'CORP PROFIT', 'UNEMPLOYED', 'INCOME', 'OIL', 'PER','PMI','POPULATION'});
% % % set(gca,'XTickLabel', {'CORP PROFIT 1','CORP PROFIT 2','CORP PROFIT 3', 'UNEMPLOYED 1', 'UNEMPLOYED 2','UNEMPLOYED 3','INCOME 1', 'INCOME 2','INCOME 3','OIL 1', 'OIL 2','OIL 3','PER 1','PER 2','PER 3', 'PMI 1','PMI 2','PMI 3','POPULATION 1','POPULATION 2','POPULATION 1'},'FontSize', 3);
% ylabel('Selected Frequency', 'FontSize', 14)
% xlabel('Variables', 'FontSize', 14)
% title('Selected Variables Frequency (lag=3)', 'FontSize', 16);    

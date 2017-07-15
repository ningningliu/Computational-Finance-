% Load data 
filename = 'c2925.prn';
dt_c1 = importdata(filename);

filename = 'c3025.prn';
dt_c2 = importdata(filename);

filename = 'c3125.prn';
dt_c3 = importdata(filename);

filename = 'c3225.prn';
dt_c4 = importdata(filename);

filename = 'c3325.prn';
dt_c5 = importdata(filename);

% 
% Get slide window volatility
% vol = sw(dt_c1);

% Get annulize asset price volatility 
vol = ann_vol(dt_c1);


% % Get normalised true option price
% tc1 = norm_c(dt_c1, 2925);
% tc2 = norm_c(dt_c2, 3025);
% tc3 = norm_c(dt_c3, 3125);
% tc4 = norm_c(dt_c4, 3225);
% tc5 = norm_c(dt_c5, 3325);

% % Get T-t and S/X
[T_t1, S1_X]= T_S(dt_c1,2925);
[T_t2, S2_X]= T_S(dt_c2,3025);
[T_t3, S3_X]= T_S(dt_c3,3125);
[T_t4, S4_X]= T_S(dt_c4,3225);
[T_t5, S5_X]= T_S(dt_c5,3325);

% % Get estimated call price from black - scholes equation 
c1_X= bs_call(dt_c1,2925);
c2_X= bs_call(dt_c2,3025);
c3_X= bs_call(dt_c3,3125);
c4_X= bs_call(dt_c4,3225);
c5_X= bs_call(dt_c5,3325);
% 
% % % 
bs_c_X = [c1_X; c2_X; c3_X;c4_X; c5_X];
T_t = [T_t1;T_t2;T_t3;T_t4;T_t5];
S_X = [S1_X;S2_X;S3_X;S4_X;S5_X];

% scatter3(S1_X,T_t1,c1_X,'fill','blue');hold on;
% scatter3(S2_X,T_t2,c2_X,'fill','green');hold on;
% scatter3(S3_X,T_t3,c3_X,'fill','m');hold on;
% scatter3(S4_X,T_t4,c4_X,'fill','c');hold on;
% scatter3(S5_X,T_t5,c5_X,'fill','r');

% scatter3(S_X,T_t,bs_c_X,'fill','blue');
% title('Simulated call price from Black-Scholes','FontSize', 14)
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('C/X','FontSize', 14)
% %


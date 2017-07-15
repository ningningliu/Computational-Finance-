% Get estimated option price from RBF model

% [w1, rbf_c1, rbf_S1_X, rbf_T_t1, price_err1, true_delta1, testInd1, mu1, cov1]= rbf_call(2925,S1_X, T_t1, c1_X,vol);
% [w2, rbf_c2, rbf_S2_X, rbf_T_t2, price_err2, true_delta2, testInd2, mu2, cov2]= rbf_call(3025,S2_X, T_t2, c2_X,vol);
% [w3, rbf_c3, rbf_S3_X, rbf_T_t3, price_err3, true_delta3, testInd3, mu3, cov3]= rbf_call(3125,S3_X, T_t3, c3_X,vol);
% [w4, rbf_c4, rbf_S4_X, rbf_T_t4, price_err4, true_delta4, testInd4, mu4, cov4]= rbf_call(3225,S4_X, T_t4, c4_X,vol);
% [w5, rbf_c5, rbf_S5_X, rbf_T_t5, price_err5, true_delta5, testInd5, mu5, cov5]= rbf_call(3325,S5_X, T_t5, c5_X,vol);
% 
% rbf_c = [rbf_c1; rbf_c2;rbf_c3;rbf_c4;rbf_c5];
% rbf_S_X = [rbf_S1_X;rbf_S2_X;rbf_S3_X;rbf_S4_X;rbf_S5_X];
% rbf_T_t = [rbf_T_t1;rbf_T_t2;rbf_T_t3;rbf_T_t4;rbf_T_t5];
% 
% price_error = [price_err1;price_err2;price_err3;price_err4;price_err5];

% boxplot of price error
% % price_error_box= [price_err1,price_err2,price_err3,price_err4,price_err5];
% price_error_box(1,5)=0;
% boxplot(price_error_box,'Labels',{'c2925','c3025','c3125','c3225','c3325'});
% ylabel('Network price error ', 'FontSize', 14)
% xlabel('options with strike price', 'FontSize', 14)
% title('Network price error for 5 call options', 'FontSize', 16);

% Network call price hat_C/X
% scatter3(rbf_S_X,rbf_T_t,rbf_c,'fill','blue');hold on;
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('estimated C/X','FontSize', 14)
% title('RBF network call price','FontSize', 14)


% % Network price error 
% z= price_error;
% for i=1:1:250
%     if z(i,:)>0.02
%         z(i,:)=0;
%     end
% end
% 
% 
% scatter3(rbf_S_X,rbf_T_t,z,'fill','green');hold on;
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('C/X error','FontSize', 14)
% title('Call price error','FontSize', 14)
% 
% 




% rbf_delt1 = delta_rbf(w1, testInd1, mu1,cov1,S1_X,T_t1,2925);
% rbf_delt2 = delta_rbf(w2, testInd2, mu2,cov2,S2_X,T_t2,3025);
% rbf_delt3 = delta_rbf(w3, testInd3, mu3,cov3,S3_X,T_t3,3125);
% rbf_delt4 = delta_rbf(w4, testInd4, mu4,cov4,S4_X,T_t4,3225);
% rbf_delt5 = delta_rbf(w5, testInd5, mu5,cov5,S5_X,T_t5,3325);

% Network deta
% rbf_delta = [rbf_delt1;rbf_delt2;rbf_delt3;rbf_delt4;rbf_delt5];
% scatter3(rbf_S_X,rbf_T_t,rbf_delta,'fill','r');hold on;
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('network delta','FontSize', 14)
% title('RBF network delta','FontSize', 14)
% 

% Delta error
% true_delta = [true_delta1;true_delta2;true_delta3;true_delta4;true_delta5];
% delta_error = rbf_delta - true_delta;
% scatter3(rbf_S_X,rbf_T_t,delta_error,'fill','r');hold on;
% xlabel('S/X','FontSize', 14)
% ylabel('T-t','FontSize', 14)
% zlabel('delta error','FontSize', 14)
% title('Delta error','FontSize', 14)

% boxplot of delta error
delta_error1= rbf_delt1- true_delta1;
delta_error2= rbf_delt2- true_delta2;
delta_error3= rbf_delt3- true_delta3;
delta_error4= rbf_delt4- true_delta4;
delta_error5= rbf_delt5- true_delta5;

delta_error_box = [delta_error1,delta_error2,delta_error3,delta_error4,delta_error5];
boxplot(delta_error_box,'Labels',{'c2925','c3025','c3125','c3225','c3325'});
ylabel('delta error ', 'FontSize', 14)
xlabel('options with strike price', 'FontSize', 14)
title('Delta error over 5 call options', 'FontSize', 16);
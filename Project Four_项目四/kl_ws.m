function [ theta ] = kl_ws(k,time_ser,N,vt )
% initialise vt, theta, wt
theta = zeros(N,3);
error = zeros(N,1);
% vt=1;
wt= k*eye(3);
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
    P_t_t= (eye(3) -Kt*Ht)*P_t_t_1;
    theta(i,:)= theta_t_t;
    theta_t_1_t_1=theta_t_t;
    P_t_1_t_1=P_t_t;
end


end


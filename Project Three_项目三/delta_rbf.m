function [ rbf_delta] = delta_rbf(w,testInd,mu, cov,S_X, T_t,K )
stock_price = S_X*K;
[row col] = size(stock_price);
syms S
% x= [S/K T_t(1,:)]';
% c= w(1,:)*(x-mu(1,:)')'*cov(:,:,1)*(x-mu(1,:)')+ w(2,:)*(x-mu(2,:)')'*cov(:,:,2)*(x-mu(2,:)')...
%     + w(3,:)*(x-mu(3,:)')'*cov(:,:,3)*(x-mu(3,:)')+ w(4,:)*(x-mu(4,:)')'*cov(:,:,4)*(x-mu(4,:)')...
%     + w(5,:)*S/K + w(6,:)*T_t(1,:) + w(7,:) ;
%   
% c_d= diff(c,S);
% delta= double(subs(c_d,S,3000));
delta= zeros(row,1);
for i = 1:1:row
    x= [S/K T_t(i,:)]';
    c= w(1,:)*(x-mu(1,:)')'*cov(:,:,1)*(x-mu(1,:)')+ w(2,:)*(x-mu(2,:)')'*cov(:,:,2)*(x-mu(2,:)')...
    + w(3,:)*(x-mu(3,:)')'*cov(:,:,3)*(x-mu(3,:)')+ w(4,:)*(x-mu(4,:)')'*cov(:,:,4)*(x-mu(4,:)')...
    + w(5,:)*S/K + w(6,:)*T_t(i,:) + w(7,:) ;
    c_d = diff(c,S);
    delta (i,:)= double(subs(c_d, S, stock_price(i,:)));
end

rbf_delta = delta(testInd,:);
end


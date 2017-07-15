function [w, rbf_c, rbf_S_X, rbf_T_t, error, true_call_delta, testInd,mu, cov] = rbf( K,S_X, T_t,C_X,vol )
% construct data vector x
x= [S_X T_t];
[row col] = size(x);
% split train and test set
Q= row;
trainRatio = 0.7;
valRatio =0;
testRatio =0.3;
[trainInd,valInd,testInd] = dividerand(Q,trainRatio,valRatio,testRatio);
train_x = x(trainInd,:);
train_C_X= C_X(trainInd,:);

% extract parameter mu and cov
GMModel = fitgmdist(train_x,4);
mu= GMModel.mu;
cov= GMModel.Sigma;
% Construct design matrix
A_x = x';
A = ones(166,7);
for j = 1:1:4
    for i=1:1:166
        A(i,j)= (A_x(:,i)-mu(j,:)')'*cov(:,:,j)*(A_x(:,i)-mu(j,:)');
    end
end
A(:,5)= S_X;
A(:,6)= T_t;
train_A= A(trainInd,:);
test_A= A(testInd,:);
% Etimate weights by least square 
w = train_A\train_C_X;

% Estimated rbf_c
rbf_c = test_A*w;
rbf_S_X = x(testInd,1);
rbf_T_t = x(testInd,2);

% Estimate price error hat_C/X - C/X
test_C_X= C_X(testInd,:);
error = rbf_c - test_C_X;

% Construct black-scholes delta
% [CallDelta, PutDelta] = blsdelta(Price,Strike,Rate,Time,Volatility,Yield)
price = S_X(testInd,:)*K;
time = T_t (testInd,:);
r = 0.06;
[row col]= size(price);
true_call_delta = zeros(row,1);
for i=1:1:row
    [true_call_delta(i,:), p_delta]= blsdelta(price(i,:),K, r, time(i,:),vol);
end 

end



% NaiveMV function to complete Efficient Frontier
%
function [PRisk_cvx, PRoR_cvx, PWts_cvx] = NaiveMV_cvx(ERet, ECov, NPts)
ERet = ERet(:); % makes sure it is a column vector
NAssets = length(ERet); % get number of assets
% vector of lower bounds on weights
V0 = zeros(NAssets, 1);
% row vector of ones
V1 = ones(1, NAssets);
% set medium scale option
options = optimset('LargeScale', 'off');
% Find the maximum expected return
%
n=3;
cvx_begin quiet
variable MaxReturnWeights(n)
    minimize (MaxReturnWeights'*(-ERet))
    subject to
        MaxReturnWeights'* ones(n,1)== 1;
        MaxReturnWeights >= V0 ;
cvx_end
MaxReturn = MaxReturnWeights' * ERet;
%
% Find the minimum variance return
% MinVarWeights = quadprog(ECov,V0,[],[],V1,1,V0,[],[],options);
cvx_begin quiet
variable MinVarWeights(n)
    minimize (MinVarWeights'*ECov* MinVarWeights)
    subject to
        MinVarWeights'* ones(n,1)== 1;
        MinVarWeights >= V0;
cvx_end
MinVarReturn = MinVarWeights' * ERet;
MinVarStd = sqrt(MinVarWeights' * ECov * MinVarWeights);
%
% check if there is only one efficient portfolio
if MaxReturn > MinVarReturn
    RTarget = linspace(MinVarReturn, MaxReturn, NPts);
    NumFrontPoints = NPts;
else
    RTarget = MaxReturn;
    NumFrontPoints = 1;
end
% Store first portfolio
PRoR_cvx = zeros(NumFrontPoints, 1);
PRisk_cvx = zeros(NumFrontPoints, 1);
PWts_cvx = zeros(NumFrontPoints, NAssets);
PRoR_cvx(1) = MinVarReturn;
PRisk_cvx(1) = MinVarStd;
PWts_cvx(1,:) = MinVarWeights(:)';
% trace frontier by changing target return
VConstr = ERet';
A = [V1 ; VConstr ];
B = [1 ; 0];
for point = 2:NumFrontPoints
    B(2) = RTarget(point);
%     Weights = quadprog(ECov,V0,[],[],A,B,V0,[],[],options);
    cvx_begin quiet
        variable Weights(n)
            minimize (Weights'*ECov* Weights)
            subject to
                Weights'* ones(n,1)== 1;
                A* Weights== B;
                Weights >= V0;
                
    cvx_end
    PRoR_cvx(point) = dot(Weights, ERet);
    PRisk_cvx(point) = sqrt(Weights'*ECov*Weights);
    PWts_cvx(point, :) = Weights(:)';
end

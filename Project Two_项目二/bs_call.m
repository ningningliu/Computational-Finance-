function [ vol_est,diff] = bs_call( data,K )
dt=data(:,3);
T= 222;
tau= 252;
win_size = round(T/4);
n= win_size-1;
vol_est= zeros((T-win_size),4);
ui_container = zeros(win_size,1);
r = 0.06;
price_bs = zeros((T-win_size),1);

for i = win_size+1:1:T
    j= i-win_size;
    if j== 1
        ui_container(1,1)= log(dt(1,:)/dt(1,:));
        for j=2:1:win_size
            ui_container(j,1)=log(dt(j,:)/dt(j-1,:));
        end
    else
        for index = 1:1:win_size
            ui_container(index,1)= log(dt(j+index-1,:)/dt(j+index-2,:));
        end
    end
    vol_est(j,1)= sum(ui_container.^2);
    vol_est(j,2)= (sum(ui_container))^2;
    vol_est(j,3) = sqrt(vol_est(j,1)/(n-1)- vol_est(j,2)/(n*(n-1)));
    vol_est(j,4)= vol_est(j,3)*sqrt(tau);
% 
   
end
for i=1:1:166
    time = (T-i-win_size)/252;
    d1= (log(dt(i+win_size,1)/K)+(r+vol_est(i,4)^2/2)*time)/(vol_est(i,4)*sqrt(time));
    d2= d1- (vol_est(i,4)*sqrt(time));
    price_bs(i,1)= dt(i+win_size,1)* normcdf(d1)- K*exp(-r*time)* normcdf(d2);
end
% diff = abs(dt(57:222,2)-price_bs);
diff = data(57:222,2)-price_bs;

end


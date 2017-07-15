function [ vol_30 ] = implied( data,K )
dt = data(:,2:3);
vol_30 = zeros(166,1);
r =0.06;
T = 222;
win_size = round(T/4);

for i =1:1:166
    j= i+win_size;
    if j+30 > 222
        c=0;
    else
        time = (T-i-win_size)/252;
        stock_price = dt(j,2);
        option_price = dt(j+30,1);
        vol_30(i,:)= blsimpv(stock_price,K,r,time,option_price,[],0,[], {'Call'});
    end
end

end


function [ norm_t, norm_stock] = T_S(dt,K)
j=1;
norm_t= zeros(166,1);
for i= 57:1:222
    norm_t(j,:)=(222-i)/253;
    j=j+1;
end
norm_stock = dt(57:222,3)/K;
% [T_t ,S]= meshgrid(norm_t, stock);

end


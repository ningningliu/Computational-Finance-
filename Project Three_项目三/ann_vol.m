function [ vol ] = ann_vol( dt )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
stock= dt(:,3);
[row col] = size(stock);
change = zeros((row-1),1);
for i= 1:1:(row-1)
    change(i,:)= (stock(i+1,:)- stock(i,:))/stock(i,:)*100;
end
daily_vol = std(change);
vol= daily_vol*15.8745;
end


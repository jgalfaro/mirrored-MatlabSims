function [ d ] = Cdist( P )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T1=power(P(1,1)-P(2,1),2);
T2=power(P(1,2)-P(2,2),2);
T3=power(P(1,3)-P(2,3),2);
d=sqrt(T1+T2+T3);
end


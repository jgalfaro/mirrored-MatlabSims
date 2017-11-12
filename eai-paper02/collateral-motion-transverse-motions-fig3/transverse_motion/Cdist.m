function [ d ] = Cdist( P )
% Calculate distance between 2 points in 3D
% Author: Jamil Kassem
% Version: June 23, 2017
%
T1=power(P(1,1)-P(2,1),2);
T2=power(P(1,2)-P(2,2),2);
T3=power(P(1,3)-P(2,3),2);
d=sqrt(T1+T2+T3);
end


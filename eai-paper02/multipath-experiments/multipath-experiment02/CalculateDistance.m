function [ d ] = CalculateDistance( X,Y,Z,X2,Y2,Z2 )
% Calculate distance between 2 points in 3D
% Author: Jamil Kassem
% Version: June 23, 2017
%
T1=power(X-X2,2);
T2=power(Y-Y2,2);
T3=power(Z-Z2,2);
d=sqrt(T1+T2+T3);
end


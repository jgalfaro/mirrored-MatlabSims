function [ PS ] = SmoothValues( P,R )
%Create new smoothed array by adding values in between
L=length(P);
Xi = 1:1/R:L;
P1 = pchip(1:L,P(1:L,1),Xi)';
P2 = pchip(1:L,P(1:L,2),Xi)';
PS=[P1(1:(L*R/2)) P2(1:(L*R/2))];
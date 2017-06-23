% Doppler shift between 2 objects moving towards each other in ULF band
% Author: Jamil Kassem
% Version: June 23, 2017
%
close all;
clear;
clear;
figure;
% speed 
v = [-2,0,0;0,-1,0]; % in kt (x1,y1,z1;x2,y2,z2)
% position 
P = [10,0,0;0,12,0]; % (x1,y1,z1;x2,y2,z2)
vr = v.*0.514444; % in m/s
%current time
t=0:1:100; % in s
% frequencies
f0 =[ 300 1200 2100 3000 ]; 
% sound speed
c = 1500; % m/s
% shift
vt=0:1:100;
D=0:1:100;
for i=1:length(t)
	PT = P+vr;
	d = Cdist(PT);
	d2 = Cdist(P);
	vt(i) = (d2-d);
	P = PT;
end
for i=1:length(f0)
	delta = f0(i).*vt/c;
    plot(t,delta);
    hold on;
    text(5,delta(6),['f = ' num2str(f0(i)) ' Hertz']);
end
xlabel('current time in (s)');
ylabel('Maximum Doppler shift (Hertz)');
title('Maximum Doppler shift in the ULF range');
grid on;

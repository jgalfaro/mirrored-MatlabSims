% Evaluation of Doppler spread
clear;
figure;
% speed 
v = 0:1:8; % in kt 
vr = v*0.514444; % in m/s
% frequencies
f0 =[ 300 1200 2100 3000 ]; 
% sound speed
c = 1500; % m/s
% shift
for i=1:length(f0)
    delta = f0(i).*vr/c;
    plot(v,delta);
    hold on;
    text(5,delta(6),['f = ' num2str(f0(i)) ' Hertz']);
end
xlabel('Relative speed (kt)');
ylabel('Maximum Doppler shift (Hertz)');
title('Maximum Doppler shift in the ULF range');
grid on;

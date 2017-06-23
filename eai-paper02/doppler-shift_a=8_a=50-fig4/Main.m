% Evaluation of Doppler spread
clear all;
close all;
Rate=4; %number of samples per second
fileID = fopen('output.txt','r');
formatSpec = '%f,%f';
sizeA = [2 Inf];
Pos = fscanf(fileID,formatSpec,sizeA);
Pos = Pos';
PosSmoothed=SmoothValues(Pos,Rate);
t=1:length(PosSmoothed);
Pos2=zeros(length(PosSmoothed),3);
Pos3=zeros(length(PosSmoothed),3);
for i=1:length(PosSmoothed)
    Pos2(i,3)=10*sin(t(i)*pi/(15*Rate));
    Pos2(i,2)=5;
    Pos2(i,1)=2;
    Pos3(i,3)=50*sin(t(i)*pi/(15*Rate));
    Pos3(i,2)=5;
    Pos3(i,1)=2;
end
% frequencies
f0 =[ 300 1200 2100 3000 ]; 
% sound speed
c = 1500; % m/s
% speed at each instant
vt=zeros(1,length(PosSmoothed));
vt2=zeros(1,length(PosSmoothed));
d2 = CalculateDistance(PosSmoothed(1,1),PosSmoothed(1,2),0,Pos2(1,1),Pos2(1,2),Pos2(1,3));
d4 = CalculateDistance(PosSmoothed(1,1),PosSmoothed(1,2),0,Pos3(1,1),Pos3(1,2),Pos3(1,3));
for i=1:length(PosSmoothed)-1
	d = CalculateDistance(PosSmoothed(i+1,1),PosSmoothed(i+1,2),0,Pos2(i+1,1),Pos2(i+1,2),Pos2(i+1,3));
	d3 = CalculateDistance(PosSmoothed(i+1,1),PosSmoothed(i+1,2),0,Pos3(i+1,1),Pos3(i+1,2),Pos3(i+1,3));
	vt(i+1) = (d2-d)*Rate;
	vt2(i+1) = (d4-d3)*Rate;
    d2=d;
    d4=d3;
end
figure;
for i=1:length(f0)
	delta = f0(i).*vt/c;
    plot(t/Rate,delta);
    text(14,delta(40),['f = ' num2str(f0(i)) ' Hertz']);
    hold on;
end
xlabel('Time (s)');
ylabel('Doppler shift (Hertz)');
title('Doppler shift in the ULF range Amplitude 10');
grid on;
figure;
for i=1:length(f0)
	delta = f0(i).*vt2/c;
    plot(t/Rate,delta);
    text(14,delta(40),['f = ' num2str(f0(i)) ' Hertz']);
    hold on;
end
hold off;
xlabel('Time (s)');
ylabel('Doppler shift (Hertz)');
title('Doppler shift in the ULF range Amplitude 50');
grid on;


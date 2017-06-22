% Evaluation of Doppler spread
animate=false;
Rate=4; %number of samples per second
fileID = fopen('output.txt','r');
formatSpec = '%f,%f';
sizeA = [2 Inf];
Pos = fscanf(fileID,formatSpec,sizeA);
Pos = Pos';
PosSmoothed=SmoothValues(Pos,Rate);
t=1:length(PosSmoothed);
Pos2=zeros(length(PosSmoothed),3);
for i=1:length(PosSmoothed)
    Pos2(i,3)=10*sin(t(i)*pi/(15*Rate));
    Pos2(i,2)=5;
    Pos2(i,1)=2;
end
% frequencies
f0 =[ 300 1200 2100 3000 ]; 
% sound speed
c = 1500; % m/s
% speed at each instant
vt=zeros(1,length(PosSmoothed));
d2 = CalculateDistance(PosSmoothed(1,1),PosSmoothed(1,2),0,Pos2(1,1),Pos2(1,2),Pos2(1,3));
for i=1:length(PosSmoothed)-1
	d = CalculateDistance(PosSmoothed(i+1,1),PosSmoothed(i+1,2),0,Pos2(i+1,1),Pos2(i+1,2),Pos2(i+1,3));
    if animate
        plot3(PosSmoothed(i+1,1),PosSmoothed(i+1,2),0,'.');
        hold on;
        plot3(Pos2(i+1,1),Pos2(i+1,2),Pos2(i+1,3),'.');
        pause(.1);
    end
    currentspeed=(d2-d)*Rate;
    d2=d;
	vt(i+1) = currentspeed;
end
figure;
for i=1:length(f0)
	delta = f0(i).*vt/c;
    subplot(1,1,1);
    plot(t/Rate,delta);
    text(14,delta(40),['f = ' num2str(f0(i)) ' Hertz']);
    hold on;
end
%subplot(2,1,2);
%plot(t/Rate,vt);
P1 = subplot(1,1,1);
xlabel(P1,'Time (s)');
ylabel(P1,'Doppler shift (Hertz)');
title(P1,'Doppler shift in the ULF range');
%P2 = subplot(2,1,2);
%xlabel(P2,'Time (s)');
%ylabel(P2,'velocity in (m/s)');
%title(P2,'Relative velocity between 2 objects');
hold off
grid on;


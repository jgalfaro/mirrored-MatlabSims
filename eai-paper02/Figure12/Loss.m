clear;
close all;
%variables changed in simulatons
% frequencies
f0 = 300; 
angle=90;%in degrees
animate=false;
figure;
EndTime=50;%in s
SampleRate=10;%sample/s
SinFrequency=.1;%Hz
amplitude=10;
direction=[cosd(angle),sind(angle)];
% position 
P = [0,0]; % (x1,y1)
P2 = [30,0;30,10;30,20;30,30;30,40]; % (x1,y1)z
% previous position pf source
PT = [0,0]; % (x1,y1)
% sound speed
c = 1500; % m/s
if animate
    S=2;
else
    S=1;
end
subplot(S,1,1);
h2 = plot(0,0);
L = subplot(S,1,1);
xlabel(L,'Time (s)');
ylabel(L,'Velocity (m/s)');
title(L,'Velocity');
PT(1)=direction(1)*amplitude*cos(-1/SampleRate*pi*SinFrequency);
PT(2)=15+direction(2)*amplitude*cos(-1/SampleRate*pi*SinFrequency);
fr=zeros(5,EndTime*SampleRate);
cosAngles=zeros(5,EndTime*SampleRate);
Ranges=zeros(5,EndTime*SampleRate);
for i=0:1/SampleRate:EndTime
    P(1)=direction(1)*amplitude*cos(i*pi*SinFrequency);
    P(2)=15+direction(2)*amplitude*cos(i*pi*SinFrequency);
	d = CalculateDistance(P(1),P(2),0,PT(1),PT(2),0);
    if(P(2)>PT(2)||P(1)>PT(1))
        vt = d*2*SampleRate;
    else
        vt = -d*2*SampleRate;
    end
    for k=1:5
        ds = CalculateDistance(P(1),P(2),0,P2(k,1),P2(k,2),0);
        cosAngle=((P2(k,1)-P(1))*direction(1)+(P2(k,2)-P(2))*direction(2))/ds;
        j=int16(i*SampleRate)+1;
        cosAngles(k,j)=acosd(cosAngle);
        fr(k,j)=c/(c-vt*cosAngle);
        Ranges(k,j) = CalculateDistance(P(1),P(2),0,P2(k,1),P2(k,2),0)/1000;
    end
    xd = get(h2,'xdata');
    yd = get(h2,'ydata');
    set(h2,'xdata',[xd(:) ; i],'ydata',[yd(:) ; vt]);
    if animate
        subplot(S,1,2);
        plot(P(1),P(2),'ro');
        hold on;
        plot(P2(1,1),P2(1,2),'o');
        plot(P2(2,1),P2(2,2),'o');
        plot(P2(3,1),P2(3,2),'o');
        plot(P2(4,1),P2(4,2),'o');
        plot(P2(5,1),P2(5,2),'o');
        hold off;
        if amplitude>40
            xlim([-amplitude amplitude]);
            ylim([-amplitude amplitude]);
        else
            xlim([-40 40]);
            ylim([-40 40]);
        end
        pause(.1);
    end
    PT(1)=P(1);
    PT(2)=P(2);
end
figure;
for i=1:length(f0)
    plot(0:1/SampleRate:EndTime,fr*f0(i)-f0(i));
end
xlabel('Time (s)');
ylabel('Doppler shift (Hertz)');
title(['Doppler shift at angle ' num2str(angle) ' frequency ' num2str(f0) 'Hz']);
legend('depth 0','depth 10','depth 20','depth 30','depth 40');
figure;
for i=1:length(f0)
    plot(0:1/SampleRate:EndTime,cosAngles);
end
xlabel('Time (s)');
xlim([0 38]);
ylim([0 180]);
ylabel('Angle (degree)');
title(['theta at beta ' num2str(angle) ' frequency ' num2str(f0) 'Hz']);
legend('depth 0','depth 10','depth 20','depth 30','depth 40');
figure;
plot(direction(1)*amplitude,15+direction(2)*amplitude,'ro');
text(2+direction(1)*amplitude,15+direction(2)*amplitude,['S(' num2str(direction(1)*amplitude) ',' num2str(15+direction(2)*amplitude) ')']);
hold on
plot(-direction(1)*amplitude,15-direction(2)*amplitude,'ro');
text(2-direction(1)*amplitude,15-direction(2)*amplitude,['S(' num2str(-direction(1)*amplitude) ',' num2str(15-direction(2)*amplitude) ')']);
for i=1:length(P2)
    hold on
    plot(30,P2(i,2),'x');
    text(31,P2(i,2)+1,['R' num2str(i) '(30,' num2str(P2(i,2)) ')']);
end
xlim([-15 38]);
ylim([0 45]);
h = gca;
set(h, 'YDir', 'reverse');
xlabel('x-position');
ylabel('Depth');
title(['Positions of sender and receivers with movement at ' num2str(angle)]);

figure;
f2 = fr.*f0/1000;
f2 = f2.*f2;
alpha=zeros(5,EndTime*SampleRate);
TL=zeros(5,EndTime*SampleRate);
for i=1:5
    for j=1:length(fr)
        alpha(i,j) = 0.11*f2(i,j)/(1+f2(i,j)) + 44*f2(i,j)/(4100+f2(i,j)) + 0.000275.*f2(i,j) + 0.003; 
        TL(i,j) = 2*10*log10(1e3*Ranges(i,j)) + alpha(i,j)*Ranges(i,j);
    end
end
semilogy(0:1/SampleRate:EndTime,TL);
legend('depth 0','depth 10','depth 20','depth 30','depth 40');
xlabel('Time (s)');
ylabel('Transmission Loss (dB)')
title(['Attenuation at receivers with movement at ' num2str(angle)]);
axis ij;
grid on;
axis([1 50 26 34]);
clear;
close all;
%variable changed in simulatons
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
P2 = [30,0]; % (x1,y1)
% previous position pf source
PT = [0,0]; % (x1,y1)
% frequencies
f0 = [300,1500,3000]; 
% sound speed
c = 1500; % m/s
if animate
    S=3;
else
    S=2;
end
subplot(S,1,1);
h2 = plot(0,0);
L = subplot(S,1,1);
xlabel(L,'Time (s)');
ylabel(L,'Velocity (m/s)');
title(L,'Velocity');
subplot(S,1,2);
h3 = plot(0,0);
L = subplot(S,1,2);
xlabel(L,'Time (s)');
ylabel(L,'Angle (degrees)');
title(L,'Angle');
PT(1)=direction(1)*amplitude*cos(-1/SampleRate*pi*SinFrequency);
PT(2)=direction(2)*amplitude*cos(-1/SampleRate*pi*SinFrequency);
fr=zeros(EndTime*SampleRate,1);
fr2=zeros(EndTime*SampleRate,1);
dif=0;
for i=0:1/SampleRate:EndTime
    P(1)=direction(1)*amplitude*cos(i*pi*SinFrequency);
    P(2)=direction(2)*amplitude*cos(i*pi*SinFrequency);
	d = CalculateDistance(P(1),P(2),0,PT(1),PT(2),0);
    if(P(2)>PT(2)||P(1)>PT(1))
        vt = d*2*SampleRate;
    else
        vt = -d*2*SampleRate;
    end
	ds = CalculateDistance(P(1),P(2),0,P2(1),P2(2),0);
    cosAngle=((P2(1)-P(1))*direction(1)+(P2(2)-P(2))*direction(2))/ds;
    j=int16(i*SampleRate)+1;
    fr2(j)=(1+vt*cosAngle/c);
    fr(j)=c/(c-vt*cosAngle);
    dif=dif+fr2(j)-fr(j);
    xd = get(h2,'xdata');
    yd = get(h2,'ydata');
    set(h2,'xdata',[xd(:) ; i],'ydata',[yd(:) ; vt]);
    xd = get(h3,'xdata');
    yd = get(h3,'ydata');
    set(h3,'xdata',[xd(:) ; i],'ydata',[yd(:) ; acosd(cosAngle)]);
    if animate
        subplot(4,1,4);
        plot(P(1),P(2),'ro');
        hold on;
        plot(P2(1),P2(2),'o');
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
    plot(0:1/SampleRate:EndTime,fr*f0(i)-f0(i),'b');
    hold on;
    plot(0:1/SampleRate:EndTime,fr2.*f0(i)-f0(i),'r');
    text(20/SampleRate,fr(20)*f0(i)-f0(i),['f0 = ' num2str(f0(i)) ' Hertz']);
end
xlabel('Time (s)');
ylabel('Doppler shift (Hertz)');
title(['Doppler shift at angle ' num2str(angle)]);
legend('moving sender','moving receiver');
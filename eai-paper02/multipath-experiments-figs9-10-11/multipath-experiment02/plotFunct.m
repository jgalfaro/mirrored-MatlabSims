function plotFunct(V1,A1,subgroup1_plotbox)
% Differnece in Doppler between moving transmitter and moving receiver
% Author: Jamil Kassem
% Version: October 31, 2017
%
    %define variables
    c=1500; % m/s
    S1=[-80,50];
    R=[10,0];
    S2=[0,-10000];
    DifY=R(2)-S2(2);
    S2(1)=(DifY*S1(1)+abs(S2(2))*R(1)+R(1)*S1(2))/(DifY-S2(2)+S1(2));
    CA1=cosd(A1);
    SA1=sind(A1);
    EndTime=40;
    IF1=2;%initial frequency 1
    PR=10;
    W=2*pi;
    SR=5*IF1;%sample rate
    %plot model
    subplot(2,2,1,'Parent', subgroup1_plotbox);
    plot(S1(1),S1(2),'r.');
    hold on;
    plot(S2(1),S2(2),'b.');
    plot(R(1),R(2),'go');
    %legend('S1','S1','R','Location','northwest');
    VC1=zeros(EndTime*PR,1);%velocity 1 at each instant
    VC2=zeros(EndTime*PR,1);%velocity 2 at each instant
    Delays=zeros(EndTime*PR,1);%velocity 2 at each instant
    for i=1:EndTime
        for j=1:PR
            ST=S1;
            D11=CalculateDistance(S1(1),S1(2),0,R(1),R(2),0);
            S1(1)=S1(1)+V1*CA1/PR;
            S1(2)=S1(2)+V1*SA1/PR;
            D12=CalculateDistance(S1(1),S1(2),0,R(1),R(2),0);
            if(S1(1)<0)
                S2(1)=(DifY*ST(1)+abs(S2(2))*R(1)+R(1)*ST(2))/(DifY-S2(2)+ST(2));
            else
                S2(1)=(DifY*ST(1)+abs(S2(2))*R(1)+R(1)*ST(2))/(DifY-S2(2)+ST(2));
            end
            D21=CalculateDistance(S2(1),S2(2),0,ST(1),ST(2),0);
            D22=CalculateDistance(S2(1),S2(2),0,S1(1),S1(2),0);
            VC1((i-1)*PR+j)=(D11-D12)*PR;
            VC2((i-1)*PR+j)=(D21-D22)*PR;
            Delays((i-1)*PR+j)=(CalculateDistance(S1(1),S1(2),0,S2(1),S2(2),0)+CalculateDistance(S2(1),S2(2),0,R(1),R(2),0)-D12)/c;
        end
        plot(S1(1),S1(2),'r.');
        plot(S2(1),S2(2),'b.');
    end
    VC1((EndTime)*PR+1)=(D11-D12)*PR;
    VC2((EndTime)*PR+1)=(D21-D22)*PR;
    hold off;
    xlabel('Horizontal Axis (m)');
    ylabel('Vertical Axis (m)');
    title('Model Plot');
    %Plot velocity
    subplot(2,2,2,'Parent', subgroup1_plotbox);
    plot(0:1/PR:EndTime,VC1,'r',0:1/PR:EndTime,VC2,'b');
    xlabel('Time (s)');
    ylabel('Velocity m/s');
    title('Velocity');
    legend('s1(t)','s2(t)','Location','south');
    %plot signals
    F1(1:EndTime*PR,1)=IF1;%F1 at each instant
    F2(1:EndTime*PR,1)=IF1;%F1 at each instant
    for i=1:EndTime
        for j=1:PR
            Doppler=c/(c-VC1((i-1)*PR+j));
            F1((i-1)*PR+j)=Doppler*IF1;
            Doppler=c/(c-VC2((i-1)*PR+j));
            F2((i-1)*PR+j)=Doppler*IF1;
        end
    end
    subplot(2,2,3,'Parent', subgroup1_plotbox);
    t=1:EndTime*PR;
    plot(t/10,F1,'r',t/10,F2,'b');
    xlabel('Time (s)');
    ylabel('Frequency Hz');
    title('Frequency with Doppler shift');
    legend('D1','D2');
    %Received Signal
    FR=SR*PR;
    S1=zeros(EndTime*FR+1,1);%Signal 1 at each instant
    S2=zeros(EndTime*FR+1,1);%Signal 2 at each instant
    for St=1:SR-1
        FB=IF1*((SR-St)/SR);
        FA=F1(1)*St/SR;
        F=FB+FA;
        S1(St)=sin(W*F*(St/FR));
        FB=IF1*((SR-St)/SR);
        FA=F2(1)*St/SR;
        F=FB+FA;
        D=Delays(1)*St/SR;
        S2(St)=sin(W*F*(St/FR)+W*D);
    end
    for Sf=1:PR-1
        for St=0:SR-1
            FB=F1(Sf)*((SR-St)/SR);
            FA=F1(1+Sf)*St/SR;
            F=FB+FA;
            S1(St+Sf*SR)=sin(W*F*((St+Sf*SR)/FR));
            FB=F2(Sf)*((SR-St)/SR);
            FA=F2(1+Sf)*St/SR;
            F=FB+FA;
            DB=Delays(Sf)*((SR-St)/SR);
            DA=Delays(1+Sf)*St/SR;
            D=DB+DA;
            S2(St+Sf*SR)=sin(W*F*((St+Sf*SR)/FR)+W*D);
        end
    end
    for t=2:EndTime
        for Sf=0:PR-1
            for St=0:SR-1
                FB=F1((t-1)*PR+Sf-1)*((SR-St)/SR);
                FA=F1((t-1)*PR+Sf)*St/SR;
                F=FB+FA;
                S1((t-1)*FR+Sf*SR+St)=sin(W*F*(t-1+(St+Sf*SR)/FR));
                FB=F2((t-1)*PR+Sf-1)*((SR-St)/SR);
                FA=F2((t-1)*PR+Sf)*St/SR;
                F=FB+FA;
                DB=Delays((t-1)*PR+Sf-1)*((SR-St)/SR);
                DA=Delays((t-1)*PR+Sf)*St/SR;
                D=DB+DA;
                S2((t-1)*FR+Sf*SR+St)=sin(W*F*(t-1+(St+Sf*SR)/FR)+W*D);
            end
        end
    end
    subplot(2,2,4,'Parent', subgroup1_plotbox);
    plot(0:1/FR:EndTime,(S1+S2));
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('r(t)');
end
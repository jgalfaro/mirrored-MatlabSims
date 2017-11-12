function Plotter
f=figure('Visible','off');
subgroup1 = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 0 1 1]);
subgroup1_plotbox = uipanel('Parent', subgroup1, 'Units', 'normal', 'Position', [0 .1 1 .9]);
sugroup1_controls = uipanel('Parent', subgroup1, 'Units', 'normal', 'Position', [0 0 1 .1]);
shift = uicontrol('Style', 'slider','Min',0,'Max',1,'Value',0, 'Units', 'normal',...
    'Position', [0 .1 .22 .8],'Callback', @setshift,'Parent', sugroup1_controls );
shiftV = uicontrol('Style','text', 'Units', 'normal','Position',[.22 0 .14 .8],'String',...
    'c: 0 rad','Parent', sugroup1_controls,'FontSize',12);

a = uicontrol('Style', 'slider','Min',1,'Max',3,'Value',1, 'Units', 'normal', 'Units', 'normal',...
    'Position', [.36 .1 .22 .8],'Callback', @setshift,'Parent', sugroup1_controls );
aval = uicontrol('Style','text', 'Units', 'normal','Position',[.58 0 .1 .8],'String','a: 0',...
    'Parent', sugroup1_controls,'FontSize',12);

b = uicontrol('Style', 'slider','Min',1,'Max',3,'Value',1, 'Units', 'normal',...
    'Position', [.68 .1 .22 .8],'Callback', @setshift,'Parent', sugroup1_controls );
bval = uicontrol('Style','text', 'Units', 'normal','Position',[.9 0 .1 .8],'String',...
    'b: 0','Parent', sugroup1_controls,'FontSize',12);
f.Visible = 'on';
plotFunct(2,2.1,2.2);
    function setshift(source,event)
        shiftv = shift.Value;
        set(shiftV, 'String', ['c:' num2str(shiftv) ' rad']);
        av = a.Value;
        set(aval, 'String', ['a:' num2str(av)]);
        bv = b.Value;
        set(bval, 'String', ['b:' num2str(bv)]);
        plotFunct(shiftv,av,bv);
    end
    function plotFunct(shift,av,bv)
        z = 0:pi/40:30*pi;
        y = cos(av*z);
        y2 = cos(bv*z+shift);
        subplot(2,1,1,'Parent', subgroup1_plotbox);
        plot(z,y,z,y2,'red');
        legend(['s1(t)=cos(' num2str(av) 't)'],['s2(t)=cos(' num2str(av) 't + ' num2str(shift) ')']);
        axis([0 30*pi -2 2])
        xlabel('Time (s)');
        ylabel('Amplitude');
        subplot(2,1,2,'Parent', subgroup1_plotbox);
        plot(z,y+y2,'green');
        axis([0 30*pi -2 2]);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(['r(t) = cos(' num2str(av) 't) + cos(' num2str(av) 't + ' num2str(shift) ')']);
    end
end
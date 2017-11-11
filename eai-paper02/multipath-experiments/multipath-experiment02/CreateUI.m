function [] = CreateUI()
% Differnece in Doppler between moving transmitter and moving receiver
% Author: Jamil Kassem
% Version: October 31, 2017
%
    f=figure('Visible','off');
    subgroup1 = uipanel('Parent', f, 'Units', 'normal', 'Position', [0 0 1 1]);
    subgroup1_plotbox = uipanel('Parent', subgroup1, 'Units', 'normal', 'Position', [0 .1 1 .9]);
    sugroup1_controls = uipanel('Parent', subgroup1, 'Units', 'normal', 'Position', [0 0 1 .1]);

    uicontrol('Style','text', 'Units', 'normal','Position',[0 0 .1 .8],'String',...
        'S1','Parent', sugroup1_controls,'FontSize',12);
    V1 = uicontrol('Style', 'slider','Min',0,'Max',100,'Value',0, 'Units', 'normal',...
        'Position', [.1 .1 .25 .8],'Callback', @SetValues,'Parent', sugroup1_controls );
    VV1 = uicontrol('Style','text', 'Units', 'normal','Position',[.35 0 .2 .8],'String',...
        '0 m/s','Parent', sugroup1_controls,'FontSize',12);

    A1 = uicontrol('Style', 'slider','Min',0,'Max',90,'Value',0, 'Units', 'normal', 'Units', 'normal',...
        'Position', [.55 .1 .25 .8],'Callback', @SetValues,'Parent', sugroup1_controls );
    VA1 = uicontrol('Style','text', 'Units', 'normal','Position',[.8 0 .2 .8],'String',...
        '0 degree','Parent', sugroup1_controls,'FontSize',12);
    f.Visible = 'on';
    plotFunct(0,0,subgroup1_plotbox);
    function SetValues(source,event)
        set(VV1, 'String', [num2str(V1.Value) ' m/s']);
        set(VA1, 'String', [num2str(A1.Value) ' degree']);
        plotFunct(V1.Value,A1.Value,subgroup1_plotbox);
    end
end
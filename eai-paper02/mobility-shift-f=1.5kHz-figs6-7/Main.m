% Differnece in Doppler between moving transmitter and moving receiver
% Author: Jamil Kassem
% Version: June 23, 2017
%
clear;
close all;
prompt={'Enter a value of \beta (in degrees)'};
name = 'Beta Value';
defaultans = {'0'};
options.Interpreter = 'tex';
a = inputdlg(prompt,name,[1 40],defaultans,options);
PlotF(str2num(a{1}));
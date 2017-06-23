% Doppler shift of transmitter moving under sin function 
% with an array of 5 receivers
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
plotF(str2num(a{1}));
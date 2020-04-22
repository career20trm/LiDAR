function [target_area] = sceneGen_mkBars(myDim, spFreq)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% Generates a 2D scene of bars.
% ==================Variables==================
% myDim = 51;           % The sample dimension of the 2D scene
% spFreq = 2;           % width of a bar given in number of samples
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================

set(0,'Units','pixels')             % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector


target_area =[];
numOslits = floor(myDim/2) +1;
slit = [zeros(myDim,spFreq) ones(myDim,spFreq)];
for i = 1:numOslits;
    target_area = [target_area slit];
end;
target_area = target_area(1:myDim,1:myDim);


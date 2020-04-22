function [target_area] = sceneGen_mkSlope(myDim)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% Generates a scene with a horizintally sloping surface.
% ==================Variables==================
% myDim = 51;           % The sample dimension of the 2D scene
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================

slopeVec = 1:1:myDim;
totDim = length(slopeVec);

ms = myDim/2;
[a b] = meshgrid(-ms:1:ms, -ms:1:ms); % This generates the actual grid of x and y values.
for i = 1:totDim;
    target_area(i,:) = slopeVec;
end

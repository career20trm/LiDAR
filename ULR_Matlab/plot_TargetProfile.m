% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This script plots the target profile that is created in the dirac
% function of ULR. The plot represents the original scene in 3D.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================

load('reports/ULR_Data.mat');
[a, b] = meshgrid(xNBeam, xNBeam);
x = [];
y = [];
z = [];
for i = tDim;
        x = [x xNBeam];
        myZ = ones(1,(myDim^2))*range(i);
        z = [z myZ];
end

y = x'

size(T_p(:))
size(x)
scatter3(x,y,z);


figure;scatter3(T_p_x, T_p_y, T_p_z,10, T_p_z, 'fill')
set(gca, 'ZColor', [.2 .2 .2]);
set(gca, 'YColor', [.2 .2 .2]);
set(gca, 'XColor', [.2 .2 .2]);
set(gca, 'Color', [0 0 0]);
set(gca, 'Color', [.4 .4 .4]);
set(gca, 'Color', [1 1 1]);
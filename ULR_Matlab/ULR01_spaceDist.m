function [stdNBeam, dx, xNBeam, beam, figBeam, sz, stdFBeam, dxx, xFBeam, figDisArr, distant_array, myDim] = ULR01_spaceDist(w_o, Z, lam, zoom, msSTD)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This function is for determining the spatial energy distribution of the
% laser beam.  The main output is the distant_array, which represents the
% energy distribution in the FOV at distance Z
% ==================Variables==================
% w_o = 0.009;      %[m] Beam Waist
% lam = 565e-9;     %[m] wavelength
% Z = 100;          %[m] propagation distance
% zoom = 1;         % normally 1, but can be used for testing
% msSTD = 4;        % number of spatial samples in std/2
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ===Code=======================================
stdNBeam = w_o/sqrt(2);
dx = stdNBeam/(msSTD*2)% msSTD*2 = numSamples/Standard Deviation
dimZoom = round(msSTD*6*zoom);% beam width approx 6 STD wide
xNBeam = (-dimZoom:1:dimZoom)*dx;
%yBeam = fliplr(xBeam);
[x, y] = meshgrid(xNBeam,xNBeam);
beamAmp = 1;
beam = beamAmp*exp(-(x.^2+y.^2)/(w_o^2)); % Equation 3.9
beam(1,1) = 0;% comparable colormaps regardless of dimension or scale
norm_factor = sqrt(sum(sum(abs(beam).^2)));
beam=beam./norm_factor;
figBeam=figure;
imagesc(xNBeam,xNBeam,beam)
sz = dimZoom*2+1

%% Propagate Beam
%dxx = (sqrt(2)*lam*Z)/(6*w_o)*0.5; % Equation3.10
w_Z = w_o*(sqrt(1+(Z*lam/(pi*(w_o^2)))^2))
stdFBeam = w_Z/sqrt(2);
dxx = stdFBeam/(msSTD*2)% msSTD*2 = numSamples/Standard Deviation
xFBeam = (-dimZoom:1:dimZoom)*dxx;
myDim = dimZoom*2+1
distant_array=zeros(myDim,myDim);

[x, y] = meshgrid(xFBeam,xFBeam);
beamAmp = 1;
distant_array = beamAmp*exp(-(x.^2+y.^2)/(w_Z^2)); % Equation 3.9
distant_array(1,1) = 0;% comparable colormaps regardless of dimension or scale

figDisArr = figure
norm_factor= sqrt(sum(sum(abs(distant_array).^2)));
distant_array=distant_array.*ones(myDim,myDim)/norm_factor;
imagesc((1:myDim)*dxx,(1:myDim)*dxx,abs(distant_array));% plots as an image
colorbar

ylabel('METERS');
xlabel('METERS');

%close gcf
%close gcf

end


function [beam, dx, figBeam, sz] = ULR02_beamNear(w_o, zoom, msSTD)
% beam=zeros(sz,sz);
% for i =1:sz;
%    for j = 1:sz;
%       beam(i,j)=(1/(2*pi*stdevx*stdevy))*exp(-((i-miy)^2)/(2*(stdevy^2)))*exp(-((j-mix)^2)/(2*(stdevx^2)));
%    end
% end
% beam=beam.*ones(sz,sz)/sqrt(sum(sum(beam.*beam)));
% 
% figBeam = figure;
% norm_factor = sqrt(sum(sum(abs(beam).^2)));
% distant_array=beam.*ones(sz,sz)/norm_factor;
% fig1 = imagesc((1:sz),(1:sz),abs(beam));% plots as an image
% colorbar

%========THOMAS'S SOLUTION================
%zoom = 1; % normally 1, but can be used for testing
%msSTD = 4; 
stdBeam = w_o/sqrt(2);
dx = stdBeam/(msSTD*2)% msSTD*2 = numSamples/Standard Deviation
dimZoom = round(msSTD*6*zoom);% beam width approx 6 STD wide
xBeam = (-dimZoom:1:dimZoom)*dx;
%yBeam = fliplr(xBeam);
[x, y] = meshgrid(xBeam,xBeam);
beamAmp = 1;
beam = beamAmp*exp(-(x.^2+y.^2)/(w_o^2)); % Equation 3.9
beam(1,1) = 0;% comparable colormaps regardless of dimension or scale
norm_factor = sqrt(sum(sum(abs(beam).^2)));
beam=beam./norm_factor;
figBeam=figure;
imagesc(xBeam,xBeam,beam)
sz = dimZoom*2+1

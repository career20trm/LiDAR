function [target_area, figScene, frqStr, rho_t] = ULR03_sceneGen(sceneType, myDim, myScale, spFreq, reflect)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% Function generates the scene based on the user specification. The main
% output is the target_area.
% ==================Variables==================
% sceneType = 'wall'  % square, corner, bars, slope, cone, cone4th
% myDim = 51;         % The sample dimension of the 2D scene
% myScale = 8;        % [m] Scale the normalized scene minimum is 5[m]
% spFreq = 2;         % width of a bar given in number of samples
% reflect = .18       % Reflectivity of the surface
% ==================Future Development==========
% A future version will make use of different objects that have different
% reflectivities that will be added one at a time to the scene.  This would
% also affect the 2D array of rho_t values that contain reflectivity. But
% this model assumes that all samples have the same reflectivity. Such a
% model would also need to apply the 2D reflectivities to the calculation
% power at the detector.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ====Code======================================================
rho_t = ones(myDim,myDim)*reflect;        

% Target reflectivity at each pixel
frqStr = ' ';
%=====Bars Gen==============
if strcmp(sceneType, 'bars');
[target_area] = sceneGen_mkBars(myDim, spFreq);
frqStr = ['; Spatial Frequency = ' num2str(spFreq*2) ' [1/px] ']
%=====Slope Gen==============
elseif strcmp(sceneType, 'slope');
[target_area] = sceneGen_mkSlope(myDim);

%=====Cone4th Gen===========
% 1/4 of cone no bars
elseif strcmp(sceneType, 'cone4th');
[target_area] = sceneGen_mkCone4th(myDim, spFreq);

%=====Cone Gen==============
% Centered cone with bars
elseif strcmp(sceneType, 'cone');
[target_area] = sceneGen_mkCone(myDim, spFreq);
frqStr = ['; Spatial Frequency = ' num2str(spFreq*2) ' [1/px] ']
%=====Square Gen==============
elseif strcmp(sceneType, 'square')  ;   % Example in book
target_area=ones(myDim,myDim);       
target_area(14:38,14:38)=zeros(25,25);  

%=====Square Gen==============
elseif strcmp(sceneType, 'corner')  ;   
target_area=ones(myDim,myDim);   
dimHalf = (round(myDim/2));
target_area(1:dimHalf,1:dimHalf) = 0;

%=====Wall Gen==============
else % Default for any other value
target_area = myScale.*ones(myDim);
end

%====size
target_area(:,:) = target_area(1:myDim,1:myDim);
%====normalize
normFac = max(max(target_area));
target_area =  target_area./normFac;
%====minimum px
%target_area(1,1) = 0; 
%====scale
target_area = target_area.*myScale;

%% ======2D Graph and settings======
figScene = figure;
image(target_area, 'CDataMapping', 'scaled');
axis image;
range_min = 0;% min(min(target_area)); 
range_max = max(max(target_area));
colorbar('Location', 'EastOutside');
caxis([range_min range_max]);
set(gca, 'Color', [0 0 0]);
saveas(gcf,['reports/images/myScene2D'],'png');
saveas(gcf,['reports/images/myScene2D'],'fig');

close gcf

function [target_area] = sceneGen_mkCone(myDim, spFreq)
% ==================Description==================
% Generates a 2D scene with a parabolic shape.  Half of the cone is covered
% by bars in the foreground.
% ==================Variables==================
% myDim = 51;           % The sample dimension of the 2D scene
% spFreq = 2;           % width of a bar given in number of samples
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================
% Dimensions Generator
ms = (myDim-1)/2;
arrayMs = -ms:1:ms;

% 2D parabola generator
[a b] = meshgrid (arrayMs); % This generates the actual grid of x and y values.
target_area=(a.^2+b.^2); % Note the elementwise notation

% Generate a Boolean Vector for creating slits in matrix
boolVec = zeros(myDim,(ms+1)); % right half of unchanged
numOslits = floor(ms/2/spFreq);
a_slit = [ones(myDim,spFreq) zeros(myDim,spFreq)];
for i = 1:numOslits; % creates slits in left half of the object
    boolVec = [boolVec a_slit];
end
endOvec = zeros(1,(myDim - length(boolVec)));
boolVec = logical([boolVec endOvec]); 
% add Bars
target_area(boolVec) = 0;

%% ======2D Graph and settings======
set(0,'Units','pixels')             % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector
figScene = figure;
image(target_area, 'CDataMapping', 'scaled');
axis image;
range_min = min(min(target_area)); 
range_max = max(max(target_area));
colorbar('Location', 'EastOutside');
caxis([range_min range_max]);
set(gca, 'Color', [0 0 0]);
saveas(gcf,['reports/images/myScene2D'],'png');
saveas(gcf,['reports/images/myScene2D'],'fig');



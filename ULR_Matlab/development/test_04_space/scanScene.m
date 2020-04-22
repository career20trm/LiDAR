%% Splits up a point cloud array into matrices with a dimension of shrinkDim
% the matricies are stored as a column vector in a cell array with the same
% order as the scene.  If the original dimensions of the matrix exceeds a 
% multiple of shrinkDim, the values are omitted for simplicity.

clear all; close all; tic;
shrinkDim = 4; % Small Matrix dimensions in pixels
load('myScene', 'array2D'); % I need to be passed distance to scene, 

%=========Replace this latter==========
ms = 50;                         %=====
a = ms:-1:-ms;
b = -ms:1:ms;
%======================================

% IF BUG TRY SWAPPING a and b!!!!!!!!!! 
% assumes a,b is x,y pairs...?

numXpts = floor(length(array2D(1,:))/shrinkDim);
numYpts = floor(length(array2D(:,1))/shrinkDim);
orgScene = array2D;
newScene = [];
for iy = 1:numYpts;
    for ix = 1:numXpts;
            y_t = (iy-1)*shrinkDim + 1; % y top bound
            y_b = iy*shrinkDim;         % y bottom bound
            y_avg = (a(y_t) + a(y_b))/2;
            x_l = (ix-1)*shrinkDim + 1; % x left bound
            x_r = ix*shrinkDim;         % x right bound
            x_avg = (b(x_l) + b(x_r))/2;
            cellMat = (orgScene(y_t:y_b,x_l:x_r));
        newScene = [newScene; [x_avg y_avg cellMat(:)']]; 
        % first two values are x y pairs for image array
        % only needed for plotting results....may not be technically correct
        % save cellMat vector in a cell array
    end;
end;
save('newScene', 'newScene');
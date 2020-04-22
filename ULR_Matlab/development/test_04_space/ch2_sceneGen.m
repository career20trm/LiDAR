%% Generates a scene with a parabolic shape.  Half of it has slits in it.
% there is a wall behind it.  Then a flattened 2D array is generated.
function [x, y, z, array2D, tooFar] = ch2_sceneGen(spDim, scanDim,d_xy, z_dis, coneSlope, periodHalf)
close all;
%% ========Credit===================================================
% <http://www.astro.umd.edu/~cychen/MATLAB/ContourPlots.html>
%% =======Example of Use============================================
% figure; scatter3(x(:),y(:),z(:));
% handels.scene.sinc.x = x
% handels.scene.sinc.y = y
% handels.scene.sinc.z = z
% scatter3(x, y, z, reflectivity ,'fill')
%% ========Constants================================================
% ms = 10;                  % the mesh size for all plots
% amplitude = 100;          % of sinc
% z_dis = 50;               % position of sinc on z-axis
% half_period = 2;          % equal to half of the Spatial Period of bars
%d_xy = 1;                   % spatial differential
                            % Solid angle area from the FOV
set(0,'Units','pixels')             % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector
%% =========Code====================================================
% Dimensions Generator
ms = (spDim*scanDim-d_xy)/2;% Even number of points. Omits the zero data pt.
arrayMs = -ms:d_xy:ms;  % The range of x values. "1:1" ensures even number
mySize = length(arrayMs);

% Generate a Boolean Vector for creating slits in matrix
boolVec = ones(1,(mySize/2)); % maintains the right half of the object unchanged
numOslits = floor((mySize/2)/(periodHalf*2));
a_slit = [ones(1,periodHalf) zeros(1,periodHalf)];
for i = 1:numOslits; % creates slits in left half of the object
    boolVec = [boolVec a_slit];
end
endOvec = ones(1,(mySize - length(boolVec)));
boolVec = logical([boolVec endOvec]); % 1==>keep column and 0==> omit column

% 2D parabola generator
[a b] = meshgrid (arrayMs); % This generates the actual grid of x and y values.
array2D=(a.^2+b.^2)*coneSlope + z_dis; % Note the elementwise notation

tooFar = max(max(array2D));
array2D =  array2D./tooFar;

% Add a wall behind parabola
wall = zeros(mySize)+1.35;
array2D = sceneGen_newAct(wall, array2D);

leftWall = zeros(mySize)+z_dis;
leftWall(:,fliplr(boolVec)) = 1;
array2D = sceneGen_newAct(leftWall, array2D);
%=============NORMALIZTION=================
array2D =  array2D./tooFar; % INVESTIGATE THIS
%=============NORMALIZTION=================
 array2D(:,(~boolVec)) = 1; % Use if no wall is used
x = a(:,boolVec); % point cloud arrays
y = b(:,boolVec);
z = array2D(:,boolVec);

%======3D Graph settings======
scene3D = figure(1); 
scatter3(x(:),y(:),z(:), d_xy, 'CData', z(:));
grid on;
colormap ;
colorbar('Location', 'EastOutside');
range_min = min(z(:)); 
range_max = max(z(:));% DONT use max(array2D) because it contains "tooFar"
caxis([range_min range_max]);

set(gca, 'Color', [0 0 0]);
set(gca, 'Xlim', [-ms*1.3 ms*1.3]);% NOTE!!!!!THESE CORRESPOND TO THE R-HAND RULE
set(gca, 'Ylim', [-ms*1.3 ms*1.3]);% WITH THE XLIM ON THE "LEFT-RIGHT PROPAGATION
set(gca, 'Zlim', [0 (range_max+300)]);% REGARDLESS OF THE X....? think of this
set(gca, 'XColor', [.2 .2 .2]);
set(gca, 'YColor', [.2 .2 .2]);
set(gca, 'ZColor', [.2 .2 .2]);
set(gcf, 'Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.3) 600 900])
annotation('textarrow', [0.5,0.5], [0.18,0.35],...% Note: [x1 x2],[y1 y2]
           'String' , 'LADAR View ',...
           'color', [0 0 0], 'fontsize', 14);
set(gca, 'CameraPosition',[198 -1091 2283]); %[20*ms -2*ms -2*ms]);
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf,['images/myScene3D'],'eps2');
saveas(gcf,['images/myScene3D'],'fig');
%set(gcf,'units','normalized','outerposition',[0.7 0 .3 1]);

%======2D Graph and settings======
scene2D = figure(2);
cla;
image(arrayMs, arrayMs, array2D, 'CDataMapping', 'scaled');
axis image;
colorbar('Location', 'EastOutside');
caxis([range_min range_max]);
set(gca, 'Color', [0 0 0]);
%set(gca, 'Xlim', [1 mySize]);% NOTE!!!!!THESE CORRESPOND TO THE R-HAND RULE
%set(gca, 'Ylim', [1 mySize]);% WITH THE XLIM ON THE "LEFT-RIGHT PROPAGATION
%set(gca, 'XColor', [.2 .2 .2]);
%set(gca, 'YColor', [.2 .2 .2]);
set(gcf, 'Position',[(myScreen(:,3)*0.65) (myScreen(:,4)*0.05) 600 500])

% =======Save work==================
save('myScene.mat');
%save('array2D.mat', 'array2D');
saveas(gcf,['images/myScene2D'],'eps2');
saveas(gcf,['images/myScene2D'],'fig');

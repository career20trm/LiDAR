function [myArray2D] = sceneGen_2D(array2D, actor);
%% ========Description==============================================
% Adds an actor to the 2D array from the LADAR point of view (xy).  This is
% carried out point-by-point to find the closest surface to the LADAR at
% every point.
%% =========Assumptions==============================================
% Each ray of light can only act on one surface.  That is it can not pass
% through a transparent surface, reflect off of a second surface, and pass
% back through the first surface before being recieved at the detector.
%% =======Example of Use============================================
% [x, y, z] = sceneCloud_bars(bars_dis, half_period, ms, reflectivity)
% handels.sceneObj.barsCloud.x = x
% handels.sceneObj.barsCloud.y = y
% handels.sceneObj.barsCloud.z = z
% scatter3(x, y, z, reflectivity ,'fill')
%% ========Constants================================================
% array2D     % current 2D array in xy
% actor       % new actor on 2D scene comes from an actor's z-mesh(zMs) data  
%% =========Code====================================================
msize = length(array2D(1,:)); % gets dimension of square matrix
a = array2D; % converts matrix into vector
b = actor;   % 

for ix = 1:msize;
for iy = 1:msize;
    if b(ix,iy) <= a(ix,iy);
        a(ix,iy) = b(ix,iy);
    end;
end
end;

myArray2D = a;

function [] = mkVideo(varName, videoData, dxx)
% ====Description===============================================
% Creates and Saves an mp4 of the 3D data set 'videoData'
% First creates an AVI, but after mp4 compression the AVI is deleted.
% This function works, but could probably be written more efficiently.
% ====Variables=================================================
% varName = 'data';         % a string that is the name of the variable
% videoData = data;         % the variable that contains the 3D data
% dxx = .001;               % [m] the dx and dy of each pixel in frame
% ====Credit=====================================================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book "Direct Detection LADAR Systems" by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================
% Preallocate movie structure
nFrames = size(squeeze(videoData(1,1,:)));
xDim = size(squeeze(videoData(:,1,1)));

mov(1:nFrames) = struct('cdata', [],'colormap', []);

% Setup figure
figure;
axis tight;
clim_Max = max(max(max(videoData)));
clim_Min = min(min(min(videoData)));

% Visit each time in the range gate
for tk = 1:nFrames;
    tk
    myimg = squeeze(videoData(:,:,tk));
    imagesc((1:xDim)*dxx, (1:xDim)*dxx, myimg)
    %image(myimg, 'CData', myimg,'CDataMapping', 'scaled');
    caxis([clim_Min clim_Max]);
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
    title(varName, 'fontsize', 12);
    colorbar
    pause(0.03);
    mov(tk) = getframe(gcf);
    if (videoData(25,25,tk)) > 1;
        display(num2str(tk));
    end;
end;

% Create AVI file
movie2avi(mov, [varName '.avi'], 'compression', 'None');

% Render with mp4 compression
readerObj = VideoReader([varName '.avi']);
writerObj = VideoWriter([varName '.mp4'], 'MPEG-4');

open(writerObj);
for k = 1:readerObj.NumberOfFrames;
   img = read(readerObj,k);
   writeVideo(writerObj,img);
end

close all;
close(writerObj);
clear mov nFrames tk k img ;
delete([varName '.avi']);


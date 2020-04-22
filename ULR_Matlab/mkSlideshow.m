function [moment] = mkSlideshow(varName, myVar, dxx)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ====Description===============================================
% Displays a slideshow of the 3d data set 'myVar'
% 'moment' is the frame that will most likely have a good signal
% for representing the 3D data in a single image.  'moment' is use by the
% mkReport script.
% ====Variables=================================================
% varName = 'data';         % a string that is the name of the variable
% myVar = data;             % the variable that contains the 3D data
% dxx = .001;               % [m] the dx and dy of each pixel in frame
% ====Credit=====================================================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book "Direct Detection LADAR Systems" by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================
nFrames = max(size(squeeze(myVar(1,1,:))))
xDim = max(size(squeeze(myVar(:,1,1))));

% initialize waitbar before video figure
hw = waitbar(0,'', 'Position', [800 100 400 100]); 

myFig = figure('Position', [800 300 1000 800]);
myMax = max(max(max(myVar)));
myMin = min(min(min(myVar)));
caxis([myMin myMax]);
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
midPx = round(length(myVar(:,1,1))/2);% index of middle pixel
display('Significant signal in the following frames:');
%=== Beam wavefront
if true;%strcmp(frameAx, 't')
iVec = [];
for i = 1:nFrames;
    myimg = squeeze(myVar(:,:,i));
    imagesc((1:xDim)*dxx, (1:xDim)*dxx, myimg)
    %image(myimg, 'CData', myimg,'CDataMapping', 'scaled');
    caxis([myMin myMax]);
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
    title(varName, 'fontsize', 12);
    colorbar
    waitbar(i/nFrames,hw, sprintf('Slide Show Now Playing \n%.0f%%',100*i/nFrames));

    %pause(0.3);
    if (myVar(midPx,midPx,i))/myMax > 0.3; % if px is above noise
        iVec = [iVec i];
        display(num2str(i));
    end;

end;
moment = round(mean(iVec));
if moment==0 || isnan(moment) || isinf(moment); 
    moment=1; 
end
end
close gcf
close(hw)

%=== Beam spread
if false;%strcmp(frameAx, 'x')
iVec = [];
for i = 1:(length(myVar(:,1,1)));
    
%     for i = 1:(length(myVar(1,1,:)))
%         irow = squeeze(sum(P_t(:,:,i)));
%         myimg(i,:) = irow
%     end
    
    myimg = squeeze(sum(myVar));
    image(myimg, 'CData', myimg,'CDataMapping', 'scaled');
    caxis([myMin myMax]);
    colorbar
    pause(0.03);
    if (myVar(midPx,midPx,i))/myMax > 0.3; % if px is above noise
        iVec = [iVec i];
        display(num2str(i));
    end;
end;
moment = round(mean(iVec));
end

%=== Beam spread BACKUP
if false;%strcmp(frameAx, 'x')
iVec = [];
for i = 1:(length(myVar(1,1,:)));
    
%     for i = 1:(length(myVar(1,1,:)))
%         irow = squeeze(sum(P_t(:,:,i)));
%         myimg(i,:) = irow
%     end
    
    myimg = squeeze(sum(myVar));
    image(myimg, 'CData', myimg,'CDataMapping', 'scaled');
    caxis([myMin myMax]);
    colorbar
    pause(0.03);
    if (myVar(midPx,midPx,i))/myMax > 0.3; % if px is above noise
        iVec = [iVec i];
        display(num2str(i));
    end;
end;
moment = round(mean(iVec));
end


end
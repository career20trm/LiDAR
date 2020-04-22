% Ladar complete Simulation for single point

%clear all; close all;
%scanScene;
clear all; close all
load('newScene');
arrayOut = [];
for row = 1:size(newScene)% length of a mat takes only the first column
    tic
    row
    x_posn =  newScene(row,1); % x value
    y_posn =  newScene(row,2); % y value
    mySurfs = newScene(row,3:end) % remainder of row are points from cloud
    numOsurfs = length(mySurfs)
    % Creates the time signal for all surfaces below
    ch2_sigGen_T_p_Noise_noPlot; 
    smoothData = mkSmooth(data, 2, 10); % careful with the last number
    % The last number will effect the number of zeros on the smoothed data
    smoothData(isnan(smoothData)) = 0; % Replace NaN with Zero
    TOF = t(find(smoothData==max(smoothData)))
    length(t)
    length(smoothData)
    length(data)
    dis = TOF*3e8/2
    newRow = [x_posn y_posn dis TOF];% smoothData];
    length(newRow)
    arrayOut = [arrayOut; newRow];
    save('arrayOut','arrayOut')
    toc
end

x = arrayOut(:,1);
y = arrayOut(:,2);
z = arrayOut(:,3);
scatter3(x,y,z)
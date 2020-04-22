%% This first 5-lines function the same as Example2_1
tic
clear all; close all;
myFigName = 'test_ch2/test_2_2_SingleSurface';
mySurfs = [1000]; %
ch2_sigGen; % Creates the time signal for all surfaces
clear all;
myFigName = 'test_ch2/test_2_2_SingleSurface';
mySurfs = [1000]; %
ch2_sigGen_T_p_Noise; % Creates the time signal for all surfaces

%% The following are tests of Example2_2
% Test 1 - Multiple surfaces
clear all; close all;
myFigName = 'test_ch2/test_2_2_aFewSurfs';
mySurfs = [995 1005 1002 1008 992 1007 999]; %
ch2_sigGen; % Creates the time signal for all surfaces
clear all; 
myFigName = 'test_ch2/test_2_2_aFewSurfs';
mySurfs = [995 1005 1002 1008 992 1007 999]; %
ch2_sigGen_T_p_Noise; % Creates the time signal for all surfaces

% Test 2 - 2D array from point cloud
clear all; close all;
myFigName = 'test_ch2/test_2_2_pointCloud';
load('array2D.mat'); % loads scene with point cloud between 0m and 100m
mySurfs = array2D(:); %
ch2_sigGen; % Creates the time signal for all surfaces
clear all;
myFigName = 'test_ch2/test_2_2_pointCloud';
load('array2D.mat'); % loads scene with point cloud between 0m and 100m
mySurfs = array2D(:); %
ch2_sigGen_T_p_Noise; % Creates the time signal for all surfaces

% Test 2 - slope
clear all; close all;
myFigName = 'test_ch2/test_2_2_slope';
mySurfs = (990:(40/1021):1030)
ch2_sigGen; % Creates the time signal for all surfaces
clear all;
myFigName = 'test_ch2/test_2_2_slope';
mySurfs = (990:(40/1021):1030)
ch2_sigGen_T_p_Noise; % Creates the time signal for all surfaces
toc

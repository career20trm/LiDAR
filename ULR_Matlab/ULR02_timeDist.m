function [Rmin, minT, Rmax, maxT, deltat, t, E_t, P_t, pulseSig, tDim, range, Sigma_w, preBuff, Z] = ULR02_timeDist(pulseE, distant_array, myDim, Z, myScale, n_h2o)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% P_t represents the total spatial/temporal distribution of the laser pulse
% energy. preBuff is an important variable that ensures the DFT is windowed
% properly. This function also establishes the range gate.
% ==================Variables====================
Sigma_w = 2e-9;     % Pulse standard deviation in units of seconds
% pulseE = .001;    %[J] Energy in laser pulse
% distant_array     % 2D spatially distributed energy of FOV at Z
% myDim             % sample dimension of distant_array
% Z = 100;          %[m] propagation distance
% myScale           %[m] user defined scale of the scene at Z
% n_h2o = 1.33      % Index of refraction for water
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ===Time Limits=================================
% !!!preBuff is very important for the DFT window!!!
% For convolution, set temporal buffer ~ half of temporal width 
% Should be the TOF equivalent in meters
preBuff = (Sigma_w*6/sqrt(2))*(3e8/n_h2o); %[m]
preBuff = 2 ;% [m]

% Limit of Z is 5[m] due to temporal width
if Z<5
    Z = 5;
    display(['The distance Z was changed to the minimum of 5 meters. '])
end

%% ===Code=======================================
Rmin = Z-preBuff;   % Minimum range in the range gate
minT=Rmin*2/(3e8/n_h2o)     % first time that the receiver will measure the return
Rmax = Z+preBuff+myScale; % Maximum range in the range gate
maxT=Rmax*2/(3e8/n_h2o)     % last time for receiver to measure
deltat=Sigma_w;     % Sample time in seconds.
t=minT:deltat:maxT; % Range of times in the range gate
tDim = max(size(t));
range = (t*(3e8/n_h2o)/2);
E_t=pulseE*abs(distant_array).^2;    % Energy distributed by diffraction
P_t=zeros(myDim,myDim,max(size(t))); % Allocate memory for 3-D pulse array

for tk=1:tDim;
    % Equation 2.13
    P_t(:,:,tk)=(E_t/((sqrt(2*pi))*Sigma_w))*exp(-((t(tk) -Z*2/(3e8/n_h2o)).^2)/(2*Sigma_w^2)); 
    % Generates the total power time signal of the pulse
    pulseSig(tk) = sum(sum(P_t(:,:,tk)));
end;


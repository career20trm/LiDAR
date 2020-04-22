function [P_conv, tau_atm, I_target, P_ref, I_receiver, P_rec, preGSig, attenReport] = ULR06_pwrRec(P_t, T_p, t, range, Z, attenCoef, tau_opt, theta_r, ap_diameter, deltat, currentVersion, classTxt, rho_t, dxx)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ====Description================================
% This function calcultaes the power that will be received at the detector
% before noise and gain are applied. The calculation is given by the range
% equation. It first convolves the energy in the laser pulse with the
% target profile specified by the scene. Then it uses a for-loop to visit
% every moment captured by the photodetector and applies the range equation
% according to the varying distances in the range gate.
% ==================Variables====================
% P_t               % The spatial and temporal energy distribution in pulse
% T_p               % The target profile defined by the scene
% t                 % TOF vector of time samples within the range gate
% range             % vector of the range gate sample distances
% Z                 % distance of scene is minimum range
% attenCoef         % the attenuation coefficient of the ocean water
% tau_opt           % optical transmission of the LADAR system
% theta_r           % the dispersion at surface; pi for lambertian
% ap_diameter       % diameter of the aperture in the LADAR system
% deltat            % the temporal sampling differential
% classTxt          % string that names the ocean
% currentVersion    % A comment about ocean model
% rho_t             % reflectivity
% dxx               % the differential of the target_area
% ==================Future Work==================
% The values of refectivity in rho_t COULD be assigened to the dirac
% instead of one, or reflectivity COULD be applied here in the power calc.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ====Convolution==========================
% For fft and ifft the 3 specifies the third dimension in the matricies
% The second pararmeter max(size(t)) specifies the minimum dimensions to
% apply the fft and ifft
P_conv = real(ifft(fft(P_t,max(size(t)),3).*fft(T_p,max(size(t)),3),max(size(t)),3)); 

%% ====Preallocation of Memory==================================
I_target = zeros(size(P_conv));     
P_ref = zeros(size(P_conv));        
I_receiver = zeros(size(P_conv));   
P_rec = zeros(size(P_conv));        
%% =====Transmission===========
tau_atm = (exp(-attenCoef.*range)) % transmission

for i = 1:length(range);
    % =====Intensity on Target===========
    % Assume tan(theta) = theta
    I_target(:,:,i) = tau_atm(i)*P_conv(:,:,i);

    % =====Power Reflected===========
    % No need to apply dA because the energy is already spatial distributed
    % Reflectivity is applied to the Dirac Target Profile
    P_ref(:,:,i) = I_target(:,:,i).*rho_t;
    % Because this version uses the beam width as the FOV it is assumed
    % that the area/beamDivergence is unity.

    % =====Intensity at the aperture===========
    I_receiver(:,:,i) = tau_atm(i)*P_ref(:,:,i)/(theta_r*range(i)^2); 

    % =====Detector Power===========
    P_rec(:,:,i) = tau_opt*(ap_diameter^2)*pi*I_receiver(:,:,i)/4; 

    % =====Total Power vs Time===========
    preGSig(i) = sum(sum(P_rec(:,:,i)))*deltat;
    
end

attenReport = [currentVersion...
    ' \n Attenuation coefficient = ' num2str(attenCoef) ' [1/m]. \n '...
    ' \n Transmision at ' num2str(Z) ' meters is approximately '...
    num2str(mean(tau_atm)) ' for this class of water; \n ' classTxt]

%% ====Videos========(Saves as mp4)=========
%mkVideo('video/P_t', P_t, t)
%mkVideo('video/I_target', I_target, t)
%mkVideo('video/P_ref', P_ref, t)
%mkVideo('video/I_receiver', I_receiver, t)
%mkVideo('reports/video/P_rec', P_rec, dxx)
%mkVideo('video/P_rec_tot', P_rec_tot, t);

%% ====Slideshows====(only displays)========
%display('I_target')
%mkSlideshow(I_target)
%display('P_ref')
%mkSlideshow(P_ref)
%display('I_receiver')
%mkSlideshow(I_receiver)
%display('P_rec')
%mkSlideshow(P_rec)
%display('P_rec_tot');
%mkSlideshow(P_rec_tot);

%% ===Show E vs time received in the array
%figure;
%signalFig = plot(t, preGSig);

end
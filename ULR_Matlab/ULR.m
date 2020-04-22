function [M] = ULR(pulseE, M, sceneType, Z, myScale, spFreq, oceanClass, reflect, G)
% ====Description===============================================
% ULR is short for Underwater LADAR Radiometry.  This is a function that
% calculates the power distribution of a single pulse of light
% emitted by the LADAR. It takes into account both spatial and temporal
% distributions by simulating the signal that is reflected back
% onto an array of photodetectors. From resulting images in time, we can
% determine the time of flight (TOF) of the light and therefore
% information about the distance of each reflecting surface in the image
% is also obtained. The decision making for the TOF of each photodetector is
% carried out by finding the time of the maximum value of power.
% ====Variables=================================================
% pulseE = .005;      % 1mW is approx. the minimum for a signal
% M                   % Coherence parameter 1=coherent; 1000=incoherent
% sceneType = 'wall'  % square, corner, bars, slope, cone, cone4th
% Z=10000;    % Distance of the first scene
% myScale = 8;        % Scale normalized scene between 1 and 9[m]
% spFreq = 1;         % Spatial frequency in Scene if needed
% oceanClass = 'med'  % Defines the type of water that is used
% reflect = .18       % Reflectivity of the surface
% G = 50              % Gain of photodetector
% ====Compatibility=============================================
% 1) Check the speckle function. It uses nbin from stats toolbox.
% 2) In the mkReport script, set the figure dimensions and position for
% your screen
% 3) The validation tests may require small modifications to the inputs of
% the ULR script.


%% ====Code======================================================

n_h2o = 1.33          % Index of refraction of water

%====Spatial Distribution=========================
w_o=.009    % Beam Waist[m]
lam=565e-9; % Wavelength of Laser % so make dxx = 0.015;
v = (3e8/n_h2o)/lam;% EM Frequency of photons
zoom = 1;   % Should be 1 normally
msSTD = 4;  % numberOsamples/2 for each STD
[stdNBeam, dx, xNBeam, beam, figBeam, sz, stdFBeam, dxx, xFBeam, figDisArr, distant_array, myDim] = ULR01_spaceDist(w_o, Z, lam, zoom, msSTD);
% We assume that the optics are such that the field of view is mapped to

%====Temporal Distribution=========================
[Rmin, minT, Rmax, maxT, deltat, t, E_t, P_t, pulseSig, tDim, range, Sigma_w, preBuff, Z] = ULR02_timeDist(pulseE, distant_array, myDim, Z, myScale, n_h2o);

%====Scene Generation=========================
[target_area, figScene, frqStr, rho_t] = ULR03_sceneGen(sceneType, myDim, myScale, spFreq, reflect);

%====Dirac Target Profile==============================
[T_p, T_p_x, T_p_y, T_p_z] = ULR04_dirac(Rmin, target_area, rho_t, myDim, t, range, dxx, n_h2o);

%====Oceanic Attenuation=========================
[attenCoef, currentVersion, classTxt] = ULR05_ocean(oceanClass);

%====Calculation of Detector Power/Energy=====
tau_opt=1;          % Receiver Optics Transmission
theta_r=pi;         % Reflection angle for Lambertian targets
ap_diameter=.01;     % Aperture diameter in units of meters
[P_conv, tau_atm, I_target, P_ref, I_receiver, P_rec, preGSig, attenReport] = ULR06_pwrRec(P_t, T_p, t, range, Z, attenCoef, tau_opt, theta_r, ap_diameter, deltat, currentVersion, classTxt, rho_t, dxx);

%====Add Noise=============================
P_rec(isnan(P_rec)) = 0; % Replace NaN with Zero
tau_atm_vec = tau_atm;
tau_atm = mean(tau_atm_vec);
quantum_eff = 0.8; % Quantum Efficiency of Photodetector
h =6.626e-34;       % Planck's constant
[N, N_speckle, T, C, Q_n_sq, N_thermal, S_irr, delta_lam, N_back, data, SNR, errorSpk, postGSig]= ULR07_noise(P_rec, rho_t, ap_diameter, Z, quantum_eff, tau_atm, tau_opt, deltat, h, v, G, dxx, M, myDim, tDim);
P_rec(isnan(P_rec)) = 0; % Replace NaN with Zero

%====Reconstruct 2D Scene==================
% mkVideo for 'mp4' is optional
% mkVideo('reports/video/data', data, dxx); 

% Shows noisy data in time
% mkSlideshow should always be run for the 'moment' output, 
[moment] = mkSlideshow('Noisy Data', data, dxx);
[result2D] = ULR08_decision(data, t, myDim, n_h2o);

%====Make Report===========================
mkDataTable; % Creates the Radiometric Table
mkReport;    % Creates the graphical report
axes(gca(myTable))% Bring to front Radiometry Table

if ~strcmp(errorSpk, '') % gives error if needed
    errorSpk
end

sprintf(attenReport)    % comments on attenuation conditions

save('reports/ULR_Data.mat');
end
function [Pbk, N_dark, N_b, N_back] = noise_background(N, S_irr, delta_lam, dA, rho_t, ap_diameter, Z, i_dark,deltat, quantum_eff, tau_atm, tau_opt, h, v)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This function calculates the amount of noise that will be added to a
% signal due to the photodetector technical specifications and the solar
% irradiance in the surrounding environment.  The current version only
% takes a single value for the reflectivity and the transmission.
% ==================Variables==================
% N = signal;       % The signal to which noise will be added
% S_irr = 300;      % [W/m^2] Solar Irradiance
% delta_lam = 10e-9 % [m] Bandwidth of the filter used with the detector
% dA = dxx*dxx;     % [m^2] area of sample
% i_dark = 0.03e-9; % [A] dark current
% deltat = ;        % Sampling time of the photodetector array
% quantum_eff = .8; % Quantum efficiency of the detector
% h = ;             % plank's constant
% v = ;             % Frequency of the light
% tau_opt = 1;      % Optical transmission of the ladar system
% tau_atm = 1;      % Transmission due to the ambient media or atmosphere
% ap_diameter;      % [m] The diameter of the aperture in the ladar system
% rho_t = .18;      % Reflectivity of the surfaces observed
% pulseE = .001;    % [J] Energy contained in the laser pulse
% theta_r = pi;     % [radians] surface dispersion, pi is lambertian
% w_o = 0.009;      %[m] Beam Waist
% lam = 565e-9;     %[m] wavelength
% Z = 100;          %[m] propagation distance
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================
my_rho_t= rho_t(1,1);

Pbk= S_irr*delta_lam*dA*my_rho_t*ap_diameter^2/(4*Z^2); % Background power collected by the receiver
electron=1.619*10^(-19);  % Elementary charge of electrons
N_dark=i_dark*deltat/electron;
N_b=Pbk*quantum_eff*tau_atm*tau_opt*deltat/(h*v)+N_dark;

N_back=poissrnd(N_b.*ones(size(N)));

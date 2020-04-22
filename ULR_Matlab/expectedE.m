function out = expectedE(tau_opt, tau_atm, ap_diameter, rho_t, pulseE, theta_r, Z)
% ==================Description==================
% This function is for determining the expected amount of energy at the 
% photodetector according to the range equation.  Calculated analytically
% rather than the numerical approach that is taken in the ULR program.
% The FOV and beam divergence is assumed to be normalized.
% ==================Variables==================
% tau_opt = 1;      % Optical transmission of the ladar system
% tau_atm = 1;      % Transmission due to the ambient media or atmosphere
% ap_diameter;      % [m] The diameter of the aperture in the ladar system
% rho_t = .18;      % Reflectivity of the surfaces observed
% pulseE = .001;    % [J] Energy contained in the laser pulse
% theta_r = pi;     % [radians] surface dispersion, pi is lambertian
 w_o = 0.009;      %[m] Beam Waist
 lam = 565e-9;     %[m] wavelength
% Z = 100;          %[m] propagation distance
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================

out = (tau_opt*(tau_atm.^2)*(ap_diameter^2)*rho_t*pulseE*pi)/(theta_r*(Z^2)*4) 

end


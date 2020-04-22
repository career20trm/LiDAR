function out = beamWidthE(w_o, lam, Z)
% ==================Description==================
% This function gives the beam width of the laser beam for distances less
% than the Rayleigh length.
% ==================Variables==================
% w_o = 0.009;      %[m] Beam Waist
% lam = 565e-9;     %[m] wavelength
% Z = 100;          %[m] propagation distance
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book "Direct Detection LADAR Systems" by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================
out = w_o*(sqrt(1+(Z*lam/(pi*(w_o^2)))^2));

end


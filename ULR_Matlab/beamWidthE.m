function out = beamWidthE(w_o, lam, Z)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
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


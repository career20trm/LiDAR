function [Q_n_sq , N_thermal] = noise_thermal(T, C, N)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This function calculates the amount of thermal noise that will be added
% to a signal due to heat in the detector.
% ==================Variables==================
% T = 300;          % [K] Temperature of detector
% C = 390;          % [pF] Capacitance of detector circuit
% N = signal;       % The signal to which noise will be added
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================

kb=1.3806504*10^(-23);
electron=1.619e-19;
Q_n_sq=kb*T*C/electron^2;
N_thermal=sqrt(Q_n_sq)*randn(size(N));
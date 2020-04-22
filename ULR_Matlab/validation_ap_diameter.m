% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.

% out = expectedE(tau_opt, tau_atm, ap_diameter, rho_t, pulseE, theta_r, Z)
myZ = 15;
% default ap_diamtere= .01
%Z
myApDiam = .008
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', 1, 50, myApDiam)
load('reports/ULR_Data.mat');
ap_diamtere_t1_Mat = preGTotE
ap_diamtere_t1_Ex = expectedE(tau_opt, tau_atm, myApDiam, reflect, pulseE, theta_r, myZ)

%Z
myApDiam = .004
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', 1, 50, myApDiam)
load('reports/ULR_Data.mat');
ap_diamtere_t2_Mat = preGTotE
ap_diamtere_t2_Ex = expectedE(tau_opt, tau_atm, myApDiam, reflect, pulseE, theta_r, myZ)


%Z
myApDiam = .001
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', 1, 50, myApDiam)
load('reports/ULR_Data.mat');
ap_diamtere_t3_Mat = preGTotE
ap_diamtere_t3_Ex = expectedE(tau_opt, tau_atm, myApDiam, reflect, pulseE, theta_r, myZ)

save('validation_ap_diamtere.mat')

clear all; close all;

load('validation_ap_diamtere.mat', 'ap_diamtere_t1_Mat', 'ap_diamtere_t2_Mat', 'ap_diamtere_t3_Mat', 'ap_diamtere_t1_Ex', 'ap_diamtere_t2_Ex', 'ap_diamtere_t3_Ex')

save('validation_ap_diamtere.mat')


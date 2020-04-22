% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.

% out = expectedE(tau_opt, tau_atm, ap_diameter, rho_t, pulseE, theta_r, Z)


%Z
myZ = 15;

%Z
pulseE = .001;
close all; ULR( pulseE, 1000, 'wall', myZ-10, 10, 2, '', 1, 50)
load('reports/ULR_Data.mat');
pulseE_t1_Mat = preGTotE
pulseE_t1_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
pulseE = .0005;
close all; ULR( pulseE, 1000, 'wall', myZ-10, 10, 2, '', 1, 50)
load('reports/ULR_Data.mat');
pulseE_t2_Mat = preGTotE
pulseE_t2_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)


%Z
pulseE = .00005;
close all; ULR( pulseE, 1000, 'wall', myZ-10, 10, 2, '', 1, 50)
load('reports/ULR_Data.mat');
pulseE_t3_Mat = preGTotE
pulseE_t3_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

save('validation_pulseE.mat')

clear all; close all;

load('validation_pulseE.mat', 'pulseE_t1_Mat', 'pulseE_t2_Mat', 'pulseE_t3_Mat', 'pulseE_t1_Ex', 'pulseE_t2_Ex', 'pulseE_t3_Ex')

save('validation_pulseE.mat')


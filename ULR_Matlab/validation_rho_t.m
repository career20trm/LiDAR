% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.

% out = expectedE(tau_opt, tau_atm, ap_diameter, rho_t, pulseE, theta_r, Z)
myZ = 15

% 
% %Z
% my_rho_t = 1;
% close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', my_rho_t, 50)
% load('reports/ULR_Data.mat');
% Z_def_Mat = preGTotE
% tau_atm = exp(-(attenCoef*myZ))
% Z_def_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
my_rho_t = .5;
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', my_rho_t, 50)
load('reports/ULR_Data.mat');
rho_t_t1_Mat = preGTotE
tau_atm = exp(-(attenCoef*myZ))
rho_t_t1_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
my_rho_t = .18;
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', my_rho_t, 50)
load('reports/ULR_Data.mat');
rho_t_t2_Mat = preGTotE
tau_atm = exp(-(attenCoef*myZ))
rho_t_t2_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
my_rho_t = .01;
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', my_rho_t, 50)
load('reports/ULR_Data.mat');
rho_t_t3_Mat = preGTotE
tau_atm = exp(-(attenCoef*myZ))
rho_t_t3_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)


save('validation_rho_t.mat')

clear all; close all;

load('validation_rho_t.mat', 'rho_t_t1_Mat', 'rho_t_t2_Mat', 'rho_t_t3_Mat', 'rho_t_t1_Ex', 'rho_t_t2_Ex', 'rho_t_t3_Ex')

save('validation_rho_t.mat')


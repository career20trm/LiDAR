% out = expectedE(tau_opt, tau_atm, ap_diameter, rho_t, pulseE, theta_r, Z)
myZ = 15

% 
% %Z
% my_tau_atm = 1;
% close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', my_tau_atm, 50)
% load('reports/ULR_Data.mat');
% Z_def_Mat = preGTotE
% tau_atm = exp(-(attenCoef*myZ))
% Z_def_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

% The following line should be inserted into ULR.m following ULR05_ocean
% attenCoef = -(log(my_tau_atm))/myZ
% and add ',my_tau_atm, myZ' to the input variables


%Z
my_tau_atm = .8;% defined for oceanType = 'test1'
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, 'test1', 1, 50)
load('reports/ULR_Data.mat');
tau_atm_t1_Mat = preGTotE
tau_atm_t1_Ex = expectedE(tau_opt, my_tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
my_tau_atm = .5;% defined for oceanType = 'test2'
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, 'test2', 1, 50)
load('reports/ULR_Data.mat');
tau_atm_t2_Mat = preGTotE
tau_atm_t2_Ex = expectedE(tau_opt, my_tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
my_tau_atm = .2;% defined for oceanType = 'test3'
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, 'test3', 1, 50)
load('reports/ULR_Data.mat');
tau_atm_t3_Mat = preGTotE
tau_atm_t3_Ex = expectedE(tau_opt, my_tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)


save('validation_tau_atm.mat')

clear all; close all;

load('validation_tau_atm.mat', 'tau_atm_t1_Mat', 'tau_atm_t2_Mat', 'tau_atm_t3_Mat', 'tau_atm_t1_Ex', 'tau_atm_t2_Ex', 'tau_atm_t3_Ex')

save('validation_tau_atm.mat')


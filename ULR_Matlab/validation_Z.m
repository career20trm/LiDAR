% out = expectedE(tau_opt, tau_atm, ap_diameter, rho_t, pulseE, theta_r, Z)

%Z
myZ = 20;
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', 1, 50)
load('reports/ULR_Data.mat');
beamWidth_t1_Mat = stdFBeam*sqrt(2);
beamWidth_t1_Ex = beamWidthE(w_o, lam, Z)
Z_t1_Mat = preGTotE
Z_t1_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

%Z
myZ = 1000;
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', 1, 50)
load('reports/ULR_Data.mat');
beamWidth_t2_Mat = stdFBeam*sqrt(2);
beamWidth_t2_Ex = beamWidthE(w_o, lam, Z)
Z_t2_Mat = preGTotE
Z_t2_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)


%Z
myZ = 10000;
close all; ULR( .0001, 1000, 'wall', myZ-10, 10, 2, '', 1, 50)
load('reports/ULR_Data.mat');
beamWidth_t3_Mat = stdFBeam*sqrt(2);
beamWidth_t3_Ex = beamWidthE(w_o, lam, Z)
Z_t3_Mat = preGTotE
Z_t3_Ex = expectedE(tau_opt, tau_atm, ap_diameter, reflect, pulseE, theta_r, myZ)

save('validation_Z.mat')

clear all; close all;

load('validation_Z.mat', 'Z_t1_Mat', 'Z_t2_Mat', 'Z_t3_Mat', 'Z_t1_Ex', 'Z_t2_Ex', 'Z_t3_Ex', 'beamWidth_t1_Mat', 'beamWidth_t2_Mat', 'beamWidth_t3_Mat', 'beamWidth_t1_Ex', 'beamWidth_t2_Ex', 'beamWidth_t3_Ex')

save('validation_Z.mat')


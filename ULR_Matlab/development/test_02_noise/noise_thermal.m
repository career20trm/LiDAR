kb=1.3806504*10^(-23);  % Boltzman's constant
T=300; % Circuit temperature in degrees Kelvin
C=1e-12; % Capacitance of detector circuit
Q_n_sq=kb*T*C/electron^2; % Variance of electron thermal noise
N_thermal=sqrt(Q_n_sq)*randn; %Gaussian thermal noise random generation
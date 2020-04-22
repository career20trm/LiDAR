kb=1.3806504*10^(-23);
T=300;
C=1e-12;% VERY IMPORTANT FOR AMOUNT OF THERMAL NOISE
electron=1.619e-19;
Q_n_sq=kb*T*C/electron^2;
N_thermal=sqrt(Q_n_sq)*randn(size(N));
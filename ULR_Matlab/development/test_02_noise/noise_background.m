S_irr= 1000; % Watts per square meter per micrometer
delta_lam=.001; % Bandwidth of receiver in units of micrometers
Pbk= S_irr*delta_lam*dA*rho_t*ap_diameter^2/(4*True_range^2); % Background power collected by the receiver
i_dark=0.75e-9; % 1 nano-amp of dark current
electron=1.619*10^(-19);  % Elementary charge of electrons
N_dark=i_dark*Pulse_width/electron;
N_b=Pbk*quantum_eff*tau_atm*tau_opt*Pulse_width/(h*v)+N_dark; % Number of photoelectrons from the background
N_back=poissrnd(N_b);  % Background number of photons with random arrival times included
clear all; close all;
True_range = 1000; % True range to target in units of meters
PRF=10  % Pulses per second
P_avg=0.1 % Average laser power in units of watts
E_t = P_avg/PRF; % Energy per pulse in units of Joules
Pulse_width = 10e-9; % Pulse width in units of seconds
P_t = E_t/Pulse_width; % Instantaneous energy in units of Watts
theta_t=.01; % Transmit beam divergence in radians
tau_atm=1; % Atmospheric Transmission
tau_opt=1; % Receiver Optics Transmission

I_target = 4*tau_atm*P_t/(pi*(True_range^2)*(theta_t^2)) % Target intensity in units of watts per meter square

rho_t=.1  % Target reflectivity
reciever_focal=.1 % Focal length of the LADAR receiver in meters
delta=1e-4 % Physical size of the detector in the LADAR receiver in meters
dA=(True_range*delta/reciever_focal)^2 % Area of the target limited by the IFOV of the receiver in square meters
P_ref = I_target*dA*rho_t; % Reflected power from the target in units of Watts
theta_r=pi; % Reflection angle for Lambertian targets
I_receiver=tau_atm*P_ref/(theta_r*(True_range)^2);  % Intensity of the signal at the receiver aperture

quantum_eff=.3; % Quantum Efficiency of the detector
ap_diameter=.01; % Aperture diameter in units of meters
h = 6.626e-34; % plank's constant
v = 3e8/1.55e-6; % frequency of light that has a 1.55 micro-meter wavelength
N = tau_opt*(ap_diameter^2)*pi*I_receiver*Pulse_width*quantum_eff/(4*h*v);

G=1:50;
trials = 1;
data = zeros(1:trials);
for i=1:trials;
x=rand; % x is uniformly distributed between 0 and 1
M=1;   % Coherence Parameter
N_speckle=icdf('nbin',x,M,M./(M+N)); % Noisy signal due to speckle

S_irr= 1000; % Watts per square meter per micrometer
delta_lam=.001; % Bandwidth of receiver in units of micrometers
Pbk= S_irr.*delta_lam.*dA.*rho_t.*ap_diameter.^2./(4.*True_range.^2); % Background power collected by the receiver
i_dark=0.75e-9; % 1 nano-amp of dark current
electron=1.619*10^(-19);  % Elementary charge of electrons
N_dark=i_dark.*Pulse_width./electron;
N_b=Pbk.*quantum_eff.*tau_atm.*tau_opt.*Pulse_width./(h.*v)+N_dark; % Number of photoelectrons from the background
N_back=poissrnd(N_b);  % Background number of photons with random arrival times included

kb=1.3806504*10^(-23);  % Boltzman's constant
T=300; % Circuit temperature in degrees Kelvin
C=1e-12; % Capacitance of detector circuit
Q_n_sq=kb.*T.*C/electron.^2; % Variance of electron thermal noise
N_thermal=sqrt(Q_n_sq).*randn; %Gaussian thermal noise random generation

data =G.*N_speckle+G.*N_back+N_thermal; 
end
SNR(G)=G.*N./sqrt(Q_n_sq+G.*G.*N.*(1+N))+G.*G.*N_b;

plot(G,SNR);


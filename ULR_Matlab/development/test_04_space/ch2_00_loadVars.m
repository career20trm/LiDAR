True_range=1000; % true range to target in meters
PRF=10;  % Pulses per second
P_avg=.1; % Average laser power in units of watts
Sigma_w = 2e-9; % Pulse standard deviation in units of seconds
theta_t=.01; % Transmit beam divergence in radians
tau_atm=1; % Atmospheric Transmission
tau_opt=1; % Receiver Optics Transmission
rho_t=.1;  % Target reflectivity
reciever_focal=.1; % Focal length of the LADAR receiver in meters
delta=1e-4; % Physical size of the detector in the LADAR receiver in meters

ap_diameter=.01; % Aperture diameter in units of meters
Rmin=990; % Minimum range in the range gate
Rmax=1010; % Maximum range in the range gate
theta_r=pi; % Reflection angle for Lambertian targets

G = 1000; % gain
h=6.626e-34;
v=3e8/1.55e-6;
quantum_eff=.075;

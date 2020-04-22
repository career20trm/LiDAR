%% loadVars ==> Loads Default constants for chapter 1
global electron h kb
electron=1.619*10^(-19);  % Elementary charge of electrons
h = 6.626e-34;            % plank's constant
kb =1.3806504*10^(-23);   % Boltzman's constant

%% Loads constants for power calculating power at detector
True_range = 1000;  % True range to target [m]
PRF=10;             % Pulses per second
P_avg=0.1;          % Average laser power [W]
Pulse_width = 10e-9;% Pulse width [s]
theta_t=.01;        % Transmit beam divergence [rad]
tau_atm=1;          % Atmospheric Transmission
tau_opt=1;          % Receiver Optics Transmission
rho_t=.1;           % Target reflectivity
reciever_focal=.1;  % Focal length of the LADAR receiver [m]
delta=1e-4;         % Size of the LADAR detector [m]
theta_r=pi;         % Reflection angle for Lambertian targets [rad]
quantum_eff=.3;     % Quantum Efficiency of the detector
ap_diameter=.01;    % Aperture diameter [m]
v = 3e8/1.55e-6;    % light frequency for 1.55 micro-meter wavelength [Hz]

%% Loads constants for apd Gain and Noise
G = 40;         % Gain of the APD
M=100;          % Coherence Parameter
S_irr= 1000;    % Watts per square meter per micrometer
delta_lam=.001; % Bandwidth of receiver in units of micrometers
i_dark=0.75e-9; % 1 nano-amp of dark current
T=300;          % Circuit temperature in degrees Kelvin
C=1e-12;        % Capacitance of detector circuit


% Functions as Example2_3 uses a DFT
numOsurfs = length(mySurfs);
minSurf = min(mySurfs);

ch2_00_loadVars; % Resets/Loads all default variables
True_range = minSurf % true range to target in meters
hi = 'loadVars'
ch2_01_laser_target; % Generates the laser pwr as a function of time
P_ref = I_target; % Reflected power from the target in Watts
hi = 'laser_target'
ch2_02_detector; % Generates the time signal at the detector
hi = 'detector'
ch2_03_target_profile; % Generates the target profile with DFT
hi = 'target_profile'
P_rec = P_rec_tot;
hi = 'P_rec'
ch2_04_noise;
hi = 'noise'
N = G*N ;%+ 5;
TotPhotons2 = round(sum(N)); % No noise
TotPhotons_noise2 = round(sum(real(data))); % Noise
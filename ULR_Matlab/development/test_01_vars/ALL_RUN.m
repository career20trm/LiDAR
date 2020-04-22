%% Runs all validation tests
tic 
% Variables used in pwrDet script               % Defaults
varTest('True_range',   (500:100:1500));        % 1000
varTest('PRF',          (1:5:51));              % 10
varTest('P_avg',        (0.2:0.2:2));           % 0.1
varTest('Pulse_width',  (0.1e-8:0.5e-8:10.1e-8)); % 1e-8
varTest('theta_t',      (0.001:0.005:.101));    % 0.01
varTest('tau_atm',      (0.5:0.1:1));           % 1
varTest('tau_opt',      (0.5:0.1:1));           % 1
varTest('rho_t',        (0.01:0.05:1));         % 0.1
varTest('reciever_focal', (0.05:0.05:0.5));     % 0.1
varTest('delta',        (1e-5:10e-5:51e-5));    % 1e-4
varTest('theta_r',      (0:(pi/8):pi));         % pi
varTest('quantum_eff',  (0.1:0.1:1));           % 0.3
varTest('ap_diameter',  (0.05:0.05:0.2));       % 0.1
varTest('v',((3e8/1.55e-6):(3e8/1.55e-6):(3e8/0.3e-6))); % 3e8/1.55e-6

% Variables used in apdGain script
varTest('G',        (5:5:50));              % 30
varTest('M',        (1:1:11));              % 100
varTest('S_irr',    (500:100:1500));        % 1000
varTest('delta_lam',(0.0005:0.0005:0.005)); % 0.001
varTest('i_dark',   (0.5e-9:0.05e-9:1e-9)); % 0.75e-9
varTest('T',        (250:10:350));          % 300

% logarithmic plotting specified in setVar script
varTest('C', [1e-18 1e-16 1e-14 1e-12 1e-10]);  % 1e-12

toc
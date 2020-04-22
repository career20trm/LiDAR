function [N, N_speckle, T, C, Q_n_sq, N_thermal, S_irr, delta_lam, N_back, data, SNR, errorSpk, postGSig]= ULR07_noise(P_rec, rho_t, ap_diameter, Z, quantum_eff, tau_atm, tau_opt, deltat, h, v, G, dxx, M, myDim, tDim)
% ====Description================================
% This function calcultaes the background and thermal noise that should be
% added to the signal based on the specifications of the detector. It also
% generates speckle (within limits of the signal strength).  The output
% 'N_speckle' contains the signal with speckle only. The output 'data'
% contains the total noisy signal with gain applied.
%
% If an error occurs due to the speckle or 'nbin' then the workaround ...
% N_speckle = N; will not apply speckle.
% ==================Variables====================
% P_rec             % The signal at the detector after attenuation
% rho_t             % reflectivity
% ap_diameter       % diameter of the aperture in the LADAR system
% Z                 % distance of scene is minimum range
% quantum_eff       % Quantum efficiency of the detector
% tau_atm           % ambient transmission due to propagation media
% tau_opt           % optical transmission of the LADAR system
% deltat            % the temporal sampling differential
% h                 % planck's constant
% v                 % frequency of light
% G                 % The photodetector Gain
% dxx               % the differential of the target_area
% M                 % the coherence paramater 1 - 1000
% myDim             % the spatial sampling dimension of the scene
% tDim              % the temporal sampling dimension in the range gate
% ==================Future Work==================
% The speckle model should either be improved or removed as it causes many
% problems and may not be important for the radiometric consideration of
% designing LADAR systems underwater.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ====Code======================================================
data = zeros(myDim,myDim,tDim);    % Allocate memory
SNR = zeros(myDim, myDim);         % Allocate memory

%==============
% Convert power to PE counts
N = P_rec*deltat*quantum_eff/(h*v);
%==============
display('Speckle Noise')
[N_speckle, errorSpk] = noise_speckle(M, N); 
%==============
display('Thermal Noise')
T=300;
C=320e-12;% VERY IMPORTANT FOR AMOUNT OF THERMAL NOISE
[Q_n_sq , N_thermal] = noise_thermal(T, C, N); 
%==============
display('Background Noise')
S_irr= 300; % Watts per square meter per micrometer
delta_lam=.001; % Bandwidth of receiver in units of micrometers
i_dark=0.03e-9; % 1 nano-amp of dark current
dA = dxx*dxx;
[~, ~, N_b, N_back] = noise_background(N, S_irr, delta_lam, dA, rho_t, ap_diameter, Z, i_dark, deltat, quantum_eff, tau_atm, tau_opt, h, v);
%==============
display('Noisy Data')
data = G.*N_speckle+G.*N_back+N_thermal; 
data(isnan(data)) = 0; % Replace NaN with Zero
%==============
display('SNR')
% The signal is contained inside of speckle so remove it for the SNR
% Calcuation and assume that an averaging technique is used for
% compensating the effect of speckle.
noise_data = G.*N_back+N_thermal; 
noise_data(isnan(noise_data)) = 0; % Replace NaN with Zero

for xi = 1:myDim;
    for yi = 1:myDim;
    px_data = squeeze(noise_data(yi,xi,:));
    px_N = squeeze(N(yi,xi,:)); % Pixel target profile
    %px_N = P_rec_tot(yi,xi,(px_T_p==max(px_T_p)));
    % Original dirac position in target profile   
    SNR(yi,xi) = max(px_N*G)/std(px_data);
    end;
end;

%% ====Total Power vs Time==================
for tk=1:tDim;
    postGSig(tk) = sum(sum(data(:,:,tk)))*(h*v);
end;
%figure;
%postGSigFig = plot(t, postGSig);

end
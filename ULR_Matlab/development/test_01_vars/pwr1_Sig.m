function [E_t, P_t] = pwr1_Sig(P_avg, PRF, Pulse_width)
% Calculates signal power from laser
%% =======CODE==================================================
E_t = P_avg./PRF; % Energy per pulse in units of Joules
P_t = E_t./Pulse_width; % Instantaneous energy in units of Watts
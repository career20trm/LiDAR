function [I_receiver, N] = pwr3_Det(tau_atm, P_ref, theta_r, True_range, tau_opt, ap_diameter, Pulse_width, quantum_eff, h, v)
% Calculates Intensity at received at LADAR and the power in [PE counts]
%% ========Code========================================================
h = 6.626e-34; % plank's constant
I_receiver=tau_atm.*P_ref./(theta_r.*(True_range).^2);  % Intensity of the signal at the receiver aperture
N = tau_opt.*(ap_diameter.^2).*pi.*I_receiver.*Pulse_width.*quantum_eff./(4*h.*v);
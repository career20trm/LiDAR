function [Pbk, N_dark, N_b] = bgNoise(S_irr, delta_lam, dA, rho_t, ap_diameter, True_range, i_dark, Pulse_width, electron, quantum_eff, tau_atm, tau_opt, h, v)
%% ========Description===============================================
% 
%% ========Variables=================================================
% S_irr, amount of solar irradiance from surrounding environment
% delta_lam, ????
% dA, area that is seen by FOV of detector 
%% ========Code======================================================
Pbk= S_irr.*delta_lam.*dA.*rho_t.*ap_diameter.^2/(4.*True_range.^2); % Background power collected by the receiver
N_dark=i_dark.*Pulse_width./electron;
N_b=Pbk.*quantum_eff.*tau_atm.*tau_opt.*Pulse_width./(h.*v)+N_dark; % Number of photoelectrons from the background
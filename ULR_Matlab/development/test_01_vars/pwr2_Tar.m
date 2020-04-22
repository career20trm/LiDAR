function [I_target, dA, P_ref] = pwr2_Tar(tau_atm, P_t, True_range, theta_t, delta, reciever_focal, rho_t)
% Calculates Intensity at target and reflected power
%% ========Code========================================================
% Target intensity in units of watts per meter square
I_target = 4.*tau_atm.*P_t./(pi.*(True_range.^2).*(theta_t.^2));
% Area of the target limited by the IFOV of the receiver in square meters
dA=(True_range.*delta./reciever_focal).^2; 
% Reflected power from the target in units of Watts
P_ref = I_target.*dA.*rho_t;
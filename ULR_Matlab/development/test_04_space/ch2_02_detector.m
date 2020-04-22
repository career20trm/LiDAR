I_receiver=tau_atm.*P_ref./(theta_r.*True_range.^2);  % Intensity at the aperture
P_rec = tau_opt.*(ap_diameter.^2).*pi.*I_receiver./4; % Received signal power
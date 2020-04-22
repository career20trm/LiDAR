
N=P_rec*deltat*quantum_eff/(h*v);% CONVERTS TO COUNTS PLUS QE!

noise_speckle;
hi = 'speckle'
noise_thermal;
hi = 'thermal'
noise_background;
hi = 'background'
data=G.*N_speckle+G.*N_back+N_thermal; 
hi = 'data saved'
data(isnan(data)) = 0; % Replace NaN with Zero
%data = data.*h*v;
SNR=G.*N/(sqrt(Q_n_sq+G*G.*N.*(1+N)+G*G.*N_b));
hi = 'SNR and done with noise'

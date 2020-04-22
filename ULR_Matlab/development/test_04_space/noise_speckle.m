x=rand; % x is uniformly distributed between 0 and 1
M=10;   % Coherence Parameter
N_speckle=icdf('nbin',x,M,M./(M+N)); % Noisy signal due to speckle
Rmin = min(mySurfs)-10;% Change Defaults to Include all points from scene
Rmax = max(mySurfs)+10;% DFT may be affected by min/max boundaries?????

E_t = P_avg/PRF; % Energy per pulse in units of Joules
minT=Rmin*2/3e8; % first time that the receiver will measure the return
maxT=Rmax*2/3e8; % last time that the receiver will measure the return
deltat=Sigma_w/10; % Sample time to ensure good pulse shape sampling
t=minT:deltat:maxT; % Range of times over which the return signal is measured
P_t=(E_t./(sqrt(2*pi).*Sigma_w)).*exp(-((t-True_range.*2./3e8).^2)./(2.*Sigma_w.^2));

I_target = 4.*tau_atm.*P_t./(pi.*(True_range.^2).*(theta_t.^2));  
dA=(True_range.*delta./reciever_focal).^2./numOsurfs; % Area of the target 
P_ref = I_target.*dA.*rho_t; % Reflected power from the target in Watts
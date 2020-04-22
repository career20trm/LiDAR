T_p=zeros(size(t)); % Create the target profile with the same number of time samples as the range gate
%T_p(1)=dA*rho_t; % The first surface is at the range of 1000 meters

for i = 1:numOsurfs;
    % Each surface is a given distance from the minimum target
    myindex = round((2*(mySurfs(i) - minSurf)/3e8)/deltat);
    if myindex == 0; % Zero is not allowed for an index
        myindex = 1; % for the case of surfaces at Rmin
    end
    %Added because multiple surfaces (px) may have the same distance
    T_p(myindex)= T_p(myindex) + dA*rho_t; 
end;

P_rec_tot=real(ifft(fft(P_rec).*fft(T_p))); % Convolution of P_rec and T_p.

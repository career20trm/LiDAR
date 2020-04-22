function [Rmin, minT, Rmax, maxT, deltat, t, E_t, P_t, pulseSig, tDim, range, P_t_NORM] = ULR03_timeDist(Sigma_w, pulseE, distant_array, myDim, Z, myScale, preBuff)
%% ====Description===============================================
% 
%% ====Variables=================================================
% 
%% ====Future Development========================================
% 
%% ====Code======================================================
save('test_timeDist.mat')
Rmin = -preBuff; % Minimum range in the range gate; Default 9990 
minT=Rmin*2/3e8 % first time that the receiver will measure the return
Rmax = preBuff;%+myScale; % Maximum range in the range gate; Default 10010 
maxT=Rmax*2/3e8 % last time that the receiver will measure the return
deltat=Sigma_w; % Sample time in seconds.
t=minT:deltat:maxT; % Range of times in the range gate
tDim = max(size(t));
range = (t*3e8/2);
E_t=pulseE*abs(distant_array).^2; % Energy distributed by diffraction
P_t=zeros(myDim,myDim,max(size(t))); % Allocate memory for 3-D pulse array

tempW = 6;% in integer values of samples
    % Equation 2.13
    % 'P_t' is an array, therefore this produces a beam image at each
    % distance that corresponds to the time
for tk = 1:tDim;
    if t(tk)>Z*2/3e8;
        if tk < (find(t==min(abs(t)))+tempW);
            P_t(:,:,tk) = E_t/tempW;
        end
    end
end

    % Images of the pulse at each range
    
    % 'pulseE' is a scalar, therefore this produces power over time
P_t_NORM = sum(sum(sum(P_t)))
pulseSig = squeeze(sum(sum(P_t)));
plot(t, pulseSig)

%P_t_NORM = sum(sum(sum(P_t)))
%P_t_NORM = sum(pulseSig*deltat);
%P_t = (P_t./P_t_NORM)*pulseE;
% The previous line should be accurate because we have dtermined the full
% width of the distant array. P_t represents the total spatial/temporal
% distribution of the powerPulse.

% Perhaps the modulous square statement in E_t should be questioned, but
% that would only change the relative distribution since we normalize again
% at the bottom

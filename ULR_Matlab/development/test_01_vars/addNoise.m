function [N_speckle, N_thermal, N_back, noisySig, SNR, stDev] = addNoise(varName, varTest, trials, varNameTex, varUnits, x_scale, figDim, M, N, Q_n_sq, N_b, G)
%% =======Monte Carlo===========================================
% The following Original data will not be changed by the if statements

org_M        = M;
org_N        = N;
org_Q_n_sq   = Q_n_sq;
org_N_b      = N_b;

if false;%trials >= 1001
   trials = 1000;
   display('Maximum number of trials is 1000.');
end

for i = 1:length(varTest); %
    tic
    % If statements ensures correct dimensions between trials and varTest
    % "if" determines vectorizing affect of varName on resulting dimensions
    if length(varTest)==(length(org_M)); 
        M = org_M(i); display('M changed');end
    if length(varTest)==(length(org_N)); 
        N = org_N(i); display('N changed');end
    if length(varTest)==(length(org_Q_n_sq)); 
        org_Q_n_sq = Q_n_sq(i); display('Q_n_sq changed');end
    if length(varTest)==(length(org_N_b)); 
        N_b = org_N_b(i); display('N_b changed');end
    
    N_speckle(i,:) = icdf('nbin',(rand(1,trials)),M,M./(M+N)); % Noisy signal due to speckle[Pbk, N_dark, N_b, N_back] = apd3_background(S_irr, delta_lam, dA, rho_t, ap_diameter, True_range, i_dark, Pulse_width, electron, quantum_eff, tau_atm, tau_opt, h, v);
    N_thermal(i,:) = sqrt(Q_n_sq).*randn(1,trials); %Gaussian thermal noise random generation[Pbk, N_dark, N_b] = apd3_background(S_irr, delta_lam, dA, rho_t, ap_diameter, True_range, i_dark, Pulse_width, electron, quantum_eff, tau_atm, tau_opt, h, v);
    N_back(i,:) = poissrnd(N_b.*(ones(1,trials)));  % Background number of photons with random arrival times included
    noisySig(i,:) = G.*N_speckle(i,:)+G.*N_back(i,:)+N_thermal(i,:);
    
    SNR(i,1) = G*N/std(noisySig(i,:));
    stDev.noisySig(i,1) = std(noisySig(i,:));
    stDev.N_speckle(i,1) = std(N_speckle(i,:));
    stDev.N_back(i,1) = std(N_back(i,:));
    stDev.N_thermal(i,1) = std(N_thermal(i,:));
    %SNR=G.*N./(sqrt(Q_n_sq)+G.*G.*N_b);
    toc

    %% =======Figures===============================================
    set(0,'Units','pixels');             % set screen units
    myScreen = (get(0,'ScreenSize'));   % screen resolution vector
        
    %% Figure - Trials (shows the actual signal of noise over #trials)
    if false;
        hT = figure('Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) figDim]); 
        plot((G.*N.*ones(1,trials)), 'y*'); hold on;
        plot(noisySig(i,:), 'black');
        plot(G.*N_speckle(i,:), 'b');
        plot(G.*N_back(i,:), 'g'); 
        plot(N_thermal(i,:), 'r'); 
        set(gca,'XScale', x_scale);
        legend('Signal Power', 'Noise Sum', 'Speckle', 'Background', 'Thermal'); 
        xlabel([num2str(trials) ' trials {@} ' varNameTex ' = ' num2str(varTest(i)) ' '], 'fontsize', 14);
        ylabel('Detector Power [PE counts] ', 'fontsize', 14);
        annotation(gcf,'textbox',[0.15 0.8 0.1 0.1],'String',...
        [varNameTex ' = ' num2str(varTest(i))],...
        'FontSize',12,'EdgeColor','black', 'HorizontalAlignment','Center',...
        'BackgroundColor',[.9 .9 .9], 'Interpreter', 'tex'); %
        saveas(hT,['images/trials/' varName '_' num2str(trials) '_' num2str(i)],'eps2');
        saveas(hT,['figures/trials/' varName '_' num2str(trials) '_' num2str(i)],'fig');
    end

end

close all;

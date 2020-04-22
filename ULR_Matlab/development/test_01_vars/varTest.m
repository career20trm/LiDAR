function [myData] = varTest(varName, varTest)
%% =======Load and Set Variables==================================
trials = 10000;
figDim = [1200 400];                 % [px] dimensions of figures
varNameTex = varName;               % Default LaTex variable name
varUnits = '[?] ';                  % Default units for graph
x_scale = 'linear';                 % Default axis type for graph
gBool = false;
%trials = 1;                        % Default number of trials
loadVars;               % Script    % Loads all Default variables
setVar;                 % Script    % Case-Switch vectorizes varName

%% =======Calculate Power=======================================
% Call pwr1_Sig, pwr2_Tar, and pwr3_Det
[E_t, P_t] = pwr1_Sig(P_avg, PRF, Pulse_width);
[I_target, dA, P_ref] = pwr2_Tar(tau_atm, P_t, True_range, theta_t, delta, reciever_focal, rho_t);
[I_receiver, N] = pwr3_Det(tau_atm, P_ref, theta_r, True_range, tau_opt, ap_diameter, Pulse_width, quantum_eff, h, v);


%% =======Calculate SNR=========================================
% Call apd1_speckle, apd2_thermal, apd3_background and SNR
Q_n_sq=kb.*T.*C./electron.^2; % Variance of electron thermal noise
[Pbk, N_dark, N_b] = bgNoise(S_irr, delta_lam, dA, rho_t, ap_diameter, True_range, i_dark, Pulse_width, electron, quantum_eff, tau_atm, tau_opt, h, v);
% Monte Carlo function
[N_speckle, N_thermal, N_back, noisySig, SNR, stDev] = addNoise(varName, varTest, trials, varNameTex, varUnits, x_scale, figDim, M, N, Q_n_sq, N_b, G);

%% =======Figures===============================================
set(0,'Units','pixels');             % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector

%% Figure - Pwr
if ~gBool;
    noiseFig = figure('Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.5) figDim]);
    %set(gcf,'units','inches','outerposition',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) 8.27 11.69]);
    set(gcf, 'PaperPositionMode', 'auto'); % !!!WYSIWYG!!!
    hPWR = subplot(121);
    plot(varTest, N); set(gca,'XScale', x_scale);
    xlabel([varNameTex ' ' varUnits ' '], 'fontsize', 24);
    ylabel('Detector Power [PE counts] ', 'fontsize', 24);
    title('(a) PE Counts vs True\_range ', 'fontsize', 24);
    set(gca,'fontsize',24)
    %saveas(hPWR,['images/varTest_' varName '_vs_N'],'eps2');
    %saveas(hPWR,['figures/varTest_' varName '_vs_N'],'fig');
end

%% Figure - SNR
if true;
    loadVars; 
    noiseFig
    hSNR = subplot(122);    
    plot(varTest, SNR); set(gca,'XScale', x_scale);
    xlabel([varNameTex ' ' varUnits ' '], 'fontsize', 24);
    ylabel('SNR ', 'fontsize', 24);
    title('(b) SNR vs True\_range ', 'fontsize', 24);
    set(gca,'fontsize',24)
    saveas(hSNR,['images/varTest_' varName '_vs_SNR_' num2str(trials)],'eps2');
    saveas(hSNR,['figures/varTest_' varName '_vs_SNR_' num2str(trials)],'fig');
end

%% Figure of variance
if false;
    hT = figure('Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) figDim]); 
    plot((G.*N.*ones(1,(length(varTest)))), 'y*'); hold on;
    plot(stDev.noisySig, 'black');
    plot(G.*stDev.N_speckle, 'b');
    plot(G.*stDev.N_back, 'g'); 
    plot(stDev.N_thermal, 'r'); 
    set(gca,'XScale', x_scale);
    legend('Signal Power', 'Noise Sum', 'Speckle', 'Background', 'Thermal'); 
    xlabel([varNameTex ' ' varUnits ' '], 'fontsize', 14);
    ylabel('Detector Power [PE counts] ', 'fontsize', 14);
    annotation(gcf,'textbox',[0.15 0.8 0.1 0.1],'String',...
    [varNameTex ' = ' num2str(varTest)],...
    'FontSize',12,'EdgeColor','black', 'HorizontalAlignment','Center',...
    'BackgroundColor',[.9 .9 .9], 'Interpreter', 'tex'); %
    saveas(hT,['images/trials/' varName '_' num2str(trials) '_'],'eps2');
    saveas(hT,['figures/trials/' varName '_' num2str(trials) '_'],'fig');
end


%% =========Output Data==========================================
allVars = who;
for i = 1:length(allVars);
    myData.(genvarname(allVars{i})) = eval(allVars{i});
end;
% How to use myData...
% mynames = fieldnames(myData) % captures names of what is in S
% myData.(mynames{ii}) % refers to ii-th stuff, useful in a loop



%% ========Termination===========================================
pause(1);
%save('snrTestInput.mat')
close all;
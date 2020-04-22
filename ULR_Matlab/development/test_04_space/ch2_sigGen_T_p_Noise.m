% Functions as Example2_3 uses a DFT
numOsurfs = length(mySurfs);
minSurf = min(mySurfs);

ch2_00_loadVars; % Resets/Loads all default variables
True_range = minSurf; % true range to target in meters
ch2_01_laser_target; % Generates the laser pwr as a function of time
P_ref = I_target; % Reflected power from the target in Watts
ch2_02_detector; % Generates the time signal at the detector
ch2_03_target_profile; % Generates the target profile with DFT
P_rec = P_rec_tot;
ch2_04_noise;
N = G*N ;%+ 5;
TotPhotons2 = round(sum(N)); % No noise
TotPhotons_noise2 = round(sum(real(data))); % Noise
%============PLOT==============
plot(t,real(N), 'r', t, data, 'g' ); hold on;
annotation(gcf,'textbox',[0.5 0.6 0.1 0.1],'String',...
    [' numOsurfs = ' num2str(numOsurfs)...
    '\newline  TotPhotons = ' num2str(TotPhotons2)...
    '\newline  TotPhotons\_noise = ' num2str(TotPhotons_noise2)...
    '\newline SNR = ' num2str(SNR)],...
    'FontSize',12,'EdgeColor','red', 'HorizontalAlignment','Center',...
    'BackgroundColor',[.7 .9 .7], 'Interpreter', 'tex'); %
saveas(gcf,['../../images/' myFigName],'eps2');
saveas(gcf,['../../images/' myFigName],'fig');
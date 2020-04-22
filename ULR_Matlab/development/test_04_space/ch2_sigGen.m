% Functions as Example2_1 for single surface
% Functions as Example2_2 for multiple surfaces
numOsurfs = length(mySurfs);
myTotP = 0; % Declare variable
for i = 1:numOsurfs;
ch2_00_loadVars; % Resets/Loads all default variables
True_range = mySurfs(i); % true range to target in meters
ch2_01_laser_target; % Generates the laser pwr as a function of time
ch2_02_detector; % Generates the time signal at the detector
myTotP = myTotP + P_rec; % I verified that this will add properly
end;
myTotP = myTotP.*G;
N_simple = myTotP.*deltat.*quantum_eff./(h*v);
TotPhotons = round(sum(N_simple));
%============PLOT==============
plot(t,N_simple, 'b' ); hold on;
annotation(gcf,'textbox',[0.5 0.8 0.1 0.1],'String',...
    [' P\_avg = ' num2str(P_avg)...
    '\newline Gain = ' num2str(G)...
    '\newline numOsurfs = ' num2str(numOsurfs)...
    '\newline TotPhotons = ' num2str(TotPhotons)],...
    'FontSize',12,'EdgeColor','blue', 'HorizontalAlignment','Center',...
    'BackgroundColor',[.7 .9 .7], 'Interpreter', 'tex', 'FitHeightToText', 'on'); %
xlabel('time [s] ', 'fontsize', 14);
ylabel('Power Output at Detector [?counts?] ', 'fontsize', 14);
saveas(gcf,['../../images/' myFigName],'eps2');
saveas(gcf,['../../images/' myFigName],'fig');
% Creates a figure comparing the effect of types of noise and the coherence
% parameter M at 1, 10, 100
% Fontsizes selected for a Latex document


load('noiseTest_Variables.mat')% ensures the variables are always the same 
G = 40

%SNR(i)=G*N/std(data);
figDim = [1200 500];                 % [px] dimensions of figures
set(0,'Units','pixels');             % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector
trialsFig = figure('Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.5) figDim]);
set(gcf, 'PaperPositionMode', 'auto'); % !!!WYSIWYG!!!

M = 1
for trials=1:20;
noise_speckle;
mySpeckle(trials) = G*N_speckle;
noise_background;
myBackground(trials) = G*N_back;
noise_thermal;
myThermal(trials) = N_thermal;
data(trials)= G*N_speckle + G*N_back + N_thermal;
sigPWR(trials) = G*N;
end
subplot(131)
plot(sigPWR/(G*N), 'yo','MarkerSize', 24); hold on
plot(data/(G*N), 'blacks','MarkerSize', 24); hold on
plot(mySpeckle/(G*N), 'r+','MarkerSize', 24); hold on
plot(myBackground/(G*N), 'bx','MarkerSize', 24); hold on
plot(myThermal/(G*N), 'gp','MarkerSize', 24); hold on
ylabel('Normalized Power [PE counts] ', 'fontsize', 24);
title('(a) Coherence of M=1', 'fontsize', 24);
set(gca,'fontsize',24)
xlim([0 20]);
ylim([-.1 3]);
myLegend = legend('Input Power', 'Output Power', 'Speckle', 'Background', 'Thermal'); 
set(myLegend,'FontSize',24, 'location', 'SouthOutside', 'orientation', 'horizontal', 'visible', 'off')


M = 100
for trials=1:20;
noise_speckle;
mySpeckle(trials) = G*N_speckle;
noise_background;
myBackground(trials) = G*N_back;
noise_thermal;
myThermal(trials) = N_thermal;
data(trials)= G*N_speckle + G*N_back + N_thermal;
sigPWR(trials) = G*N;
end
subplot(133)
plot(sigPWR/(G*N), 'yo','MarkerSize', 24); hold on
plot(data/(G*N), 'blacks','MarkerSize', 24); hold on
plot(mySpeckle/(G*N), 'r+','MarkerSize', 24); hold on
plot(myBackground/(G*N), 'bx','MarkerSize', 24); hold on
plot(myThermal/(G*N), 'gp','MarkerSize', 24); hold on
title('(c) Coherence of M=100', 'fontsize', 24);
set(gca,'fontsize',24)
myLegend = legend('Input Power', 'Output Power', 'Speckle', 'Background', 'Thermal'); 
set(myLegend,'FontSize',24, 'location', 'SouthOutside', 'orientation', 'horizontal', 'visible', 'off')
xlim([0 20]);
ylim([-.1 3]);

% Make the second plot last so the legend appears on top
M = 10
for trials=1:20;
noise_speckle;
mySpeckle(trials) = G*N_speckle;
noise_background;
myBackground(trials) = G*N_back;
noise_thermal;
myThermal(trials) = N_thermal;
data(trials)= G*N_speckle + G*N_back + N_thermal;
sigPWR(trials) = G*N;
end
subplot(132)
plot(sigPWR/(G*N), 'yo','MarkerSize', 24); hold on
plot(data/(G*N), 'blacks','MarkerSize', 24); hold on
plot(mySpeckle/(G*N), 'r+','MarkerSize', 24); hold on
plot(myBackground/(G*N), 'bx','MarkerSize', 24); hold on
plot(myThermal/(G*N), 'gp','MarkerSize', 24); hold on
myLegend = legend('Input Power', 'Output Power', 'Speckle', 'Background', 'Thermal'); 
set(myLegend,'FontSize',24, 'location', 'SouthOutside', 'orientation', 'horizontal')
xlim([0 20]);
ylim([-.1 3]);
xlabel('Trial Number \newline .', 'fontsize', 24);

title('(b) Coherence of M=10', 'fontsize', 24);
set(gca,'fontsize',24)

saveas(trialsFig,['images/noiseVariances'],'eps2');
saveas(trialsFig,['figures/noiseVariances'],'fig');

SpeckleMean = mean(mySpeckle);
SNR = G*N/std(data)
save('noiseTest_Results.mat');
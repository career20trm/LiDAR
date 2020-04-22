clear all; close all; tic
load('mySNRtestVars.mat')% ensures the variables are always the same 
G = 100;

for trials=1:100;
noise_speckle;
mySpeckle(trials) = G*N_speckle;
noise_background;
myBackground(trials) = G*N_back;
noise_thermal;
myThermal(trials) = N_thermal;
data(trials)= G*N_speckle + G*N_back + N_thermal;
sigPWR(trials) = G*N;
end
%SNR(i)=G*N/std(data);

plot(mySpeckle, 'r'); hold on
plot(myBackground, 'b'); hold on
plot(myThermal, 'g'); hold on
plot(data, 'black'); hold on
plot(sigPWR, 'y'); hold on
legend('Speckle', 'Background', 'Thermal', 'Noise Sum', 'Signal Power'); 

SpeckleMean = mean(mySpeckle)
G*N
toc;
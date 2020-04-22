function [smoothData] = mkSmooth(data, sigma, vecSize);
%% Weighted vector is gaussian...
X = -vecSize:vecSize;
myGauss = exp(-0.5*X.^2/(sigma^2)); %missing factor of:  1/(sqrt(2*pi)*sigma)
%figure;
%plot(X,myGauss)

%% mkSmooth
% <http://rosettacode.org/wiki/Averages/Simple_moving_average#MATLAB_.2F_Octave>
smoothData = tsmovavg(data, 'w',myGauss, 2); 
%plot(t,smoothData,'b');
%hold on;
%plot(t,data,'r');
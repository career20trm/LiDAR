%DFT test to show the quality of reconstruction using fft and ifft

%Read for Normalization....
% http://www.mathworks.es/matlabcentral/newsreader/view_thread/152029


clear all; close all; tic
numOcycles = 2
fund = 2*pi;
Nf = fund/3;
sf = 1;
dt = pi/16
tlim = numOcycles*fund/2;
augment = 2;
%% Sinusoid
figure(1);
t = (-tlim):dt:(tlim);
y = sin(t);
plot(t,y, 'b'); hold on;
y_DFT = ifft(fft(y));
plot(t,y_DFT, 'r'); hold on;
legend('Sinusoid','Sin DFT')

%% Windowed Sinusoid
% should compare the smallest feature of signal given by 2*dt
figure(2);
% Create window
t_w = (-augment*tlim):dt:(augment*tlim);
% WEIRD MATH BUT WORKS
buff = ((length(t_w)-1)/2)*((augment-1)/augment); % number of zeros to augment in y_w data
y_w = [zeros(1,buff) y zeros(1,buff)];
% plot
plot(t_w, y_w, 'b'); hold on;
y_w_DFT = ifft(fft(y_w));
plot(t_w, y_w_DFT, 'r'); hold on;
legend('Augmented Sinusoid','Augmented Sin DFT')

%% Sum of two Sinusoids
figure(3);


%% Hat

%% Gaussian

%% Figure Setup


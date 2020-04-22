function convFig = test_convolution(attenCoef, Z, sigma, testType)
% =======Description=============================
% This was an important test for developing the ULR model!
%
% This was designed as a 1-dim convolution test of the time signal to
% determine the most appropriate place to apply the attenuation of the
% signal as a function of the distance.
% =======Example=================================
% convFig = test_convolution(.015, 100, 2, 1)
% =======Variables===============================
% attenCoef = .015   % attenuation coefficient of fluid
% Z = 100;           % the distance where we will consider
% sigma = 3;         % Temporal std
% testType =  0;     % 0 makes 3 impulses, and 1 makes continuous impulses
myPwr = 1;           % Input power defined as unity
%========NOTES===================================
% For LADAR the calculation distance should be 2*range
% sigma = 2e-9;     In the LADAR text

% The post application of attenuation proved to be the best method because
% of its reliability at both short and long distances. However, the test at
% Z=1000 and defaultDirac = 1 shows that both post-attenuation and the weighted
% Dirac approach in T_p behave similarly. Notice that when this test 
% performed at sigma > 1 there is a noticeable offset.  The off set 
% decreases as we take the sigma value to 1/tempWidth which is a logical
% difference from the way the convolution is carried out. From this we can
% deduce that the two methods are equivalent regardless of the range
% provided that the temporal sigma value is significantly smaller than the
% deltat which is the dt between samples.  However this is not the case for
% the default LADAR model that was given in the text.

%% ====Rayleigh Sommerfield limitations====
% This section was used to experiment with some of the limits of RS

% if rs
%     
% % I found that this is the Z that inverts the power from e+ to e-
% Z = round(10^(exp(1)))
%     
% j = sqrt(-1)
% lam=565e-9
% dx = .009
% dA = dx*dx
% beamPwr = 1
% %rayleigh sommerfield point to point approx
% myPwr = dA*beamPwr*Z.*exp(2*pi*j*Z/lam)/(j*lam*Z^2)
% 
% % assume unity pwr in...
% %myPwr = Z.*exp(2*pi*j*Z/lam)/(j*lam*Z^2)
% end

%% ========Code===================================
convFig = figure('position', [1800 300 600 1000]);
% delta t for the time line - the value here is only for example
deltat = sigma;
tempWidth = 6*sigma/sqrt(2); % calculate the temporal width
%preBuff value should be defined as 6*std(timepulse) in terms of indicies
preBuff = floor(tempWidth/deltat)+1;
% Theses cases show the need for the leading temporal buffer in P_t should
% be spatially/temporally the width of temporal pulse. The logic is that
% the leading edge of the temporal pulse will get there first followed by
% the trailing edge.  Simply said the pulse should be convolved so that it
% is located to the right of the impulse and not centered!
%preBuff = floor(preBuff/2);
%preBuff = 0

%% ===========Target Profile===============
% Setting the range with the temporal "preBuff" in the range ensures that
% points at the minimum and maximum will not over lap into the opposing
% ends of the signal. Theoretically, it should also be applicable to the
% spatial buffer as well.

range = (-(Z+preBuff):(Z+preBuff))+Z;
T_p = ones(size(range))*testType; % Target Profile
T_p(1,preBuff) = 1; 
T_p(1,Z+1) = 1; 
%T_p(1,50) = 1;
T_p(1,(Z*2+1-preBuff)) = 1;

tPulse = -preBuff:(length(range)-1-preBuff); % Gives same number of indicies
P_t = myPwr*exp(-0.5*tPulse.^2/(sigma^2)); % Temporal Gaussian pulse

%=============
subplot(311);
plot(tPulse,P_t);
%ylim([0 1.5]);
title('Target Profile - vector of Dirac impulses.');
xlabel('Range [m] ');
ylabel('Energy [a.u.] ');

%=============
subplot(312);
stem(range, T_p);
ylim([0 1.5]);
title('Target Profile - vector of Dirac impulses.');
xlabel('Range [m] ');
ylabel('Weighted Impulse [a.u.] ');


%% Post convolution application of transmission
P_rec = P_t;
tSigPatt = real(ifft(fft(P_rec,max(size(range)),2).*fft(T_p,max(size(range)),2),max(size(range)),2)); 
tau_atm_sqr = (exp(-attenCoef*range)).^2;
tSigPatt = tSigPatt.*tau_atm_sqr;

%% Transmission is applied to the P_rec
tau_atm = 1.*exp(-attenCoef*Z); % Oceanic transmission only evaluated at Z
P_recZ = P_t*(tau_atm^2);
tSigZatt = real(ifft(fft(P_recZ,max(size(range)),2).*fft(T_p,max(size(range)),2),max(size(range)),2)); 

%% Transmission is applied to the Dirac T_p
% Oceanic transmission evaluated along range
% And applied to the dirac Target profile
P_recR = P_t;
tau_atm_sqr = (exp(-attenCoef*range)).^2;
T_pR = T_p.*tau_atm_sqr;
tSigRatt = real(ifft(fft(P_recR,max(size(range)),2).*fft(T_pR,max(size(range)),2),max(size(range)),2)); 

%=============
% The results of this figure show that it is necessary to apply any Range
% dependent aspects of radiometry as either a weighted dirac or post 
% convolution rather than convolving it at a single value of Z.  However at
% very far distances relative to the size of the range gate this effect 
% could become negligible.

subplot(313);
plot(range,tSigPatt,'g');
hold on;
plot(range,tSigZatt,'r');
hold on;
plot(range,tSigRatt,'b');
title('Compare two ways of attenuating...');
ylabel('Power [a.u.] ');
xlabel('Range [m] ');
legend('Post Attenuation ', 'P\_rec Attenuation ', 'T\_p Attenuation ');



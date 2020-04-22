% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.

load('reports/ULR_Data.mat');

%% ===========Spatial==============
myVec = sum(distant_array.^2); % flatten for 1-dim analysis
myDim = max(size(myVec));
myMaxPx = find(myVec==max(myVec))
pxMid = (myDim + 1)/2;
myMaxTemp = myVec(pxMid);

% compare where we find the FWHM with where it should be
hm = myMaxTemp/2;
vecT = abs(myVec-hm);
myMin = min(abs(vecT));
ihm = find(vecT==myMin)
result = (ihm(2)-ihm(1))*dx*2

%this is the sample where I should find the FWHM...
myfwhm=2*sqrt(2*log(2))*w_o

% compare where we find the FWTM with where it should be
tm = myMaxTemp/1.5;
vecT = abs(myVec-tm);
myMin = min(abs(vecT));
itm = find(vecT==myMin)
result = (itm(2)-itm(1))*dx*2
%this is the sample where I should find the FWTM...
myfwtm=2*sqrt(2*log(1.5))*w_o
display('Now for some temporal analysis')
%% ===========Temporal==============
% we need beter temporal resolution to test the acuracy of the calculation
msDim = 50
myDeltat = Sigma_w/10
myTime = (-msDim:msDim)*myDeltat;
size(myTime)
E_t = 1;
% following line taken from the temporal distribution calculation
testPulseSig=(E_t/((sqrt(2*pi))*Sigma_w))*exp(-(myTime.^2)/(2*Sigma_w^2)); 
plot(myTime, testPulseSig)

myMaxTemp = max(testPulseSig)% pulseSig is already 1-dim
mySig = testPulseSig/myMaxTemp;
pxMid = find(mySig==1)

% compare where we find the FWHM with where it should be
hm = 1/2
vecT = abs(mySig-hm);
myMin = min(abs(vecT));
ihm = find(vecT==myMin)
result = (pxMid-ihm(1))*myDeltat*2
%this is the sample where I should find the FWHM...
myfwhm=2*sqrt(2*log(2))*Sigma_w


% compare where we find the FWTM with where it should be
tm = 1/1.5;
vecT = abs(mySig-tm);
myMin = min(abs(vecT));
itm = find(vecT==myMin)
result = (pxMid-itm(1))*myDeltat*2
%this is the sample where I should find the FWTM...
myfwtm=2*sqrt(2*log(1.5))*Sigma_w









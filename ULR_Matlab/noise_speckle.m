function [N_speckle, errorSpk] = noise_speckle(M, N)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This function calculates the amount of noise that will be added to a
% signal due to speckle from laser coherence. M = 1 is coherent light.
% ==================Variables==================
% M = 100;          % nbin probability determines extent of speckle
% N = signal;       % The signal to which noise will be added
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================
maxN = max(max(max(N)))
%minN = min(min(min(N)))
%myNNans = find(N==isnan(N));
errorSpk = '';
if maxN > 1e5;
    N_speckle = N;% omits speckle feature if eceeded
    errorSpk = 'Speckle not added! Over maximum N limit.'
else

Y = M/(M+N);
%==================================
% It looks weird, but keep this. It is what limits the smallest value where
% the program can still run within a decent time frame! The number is
% probably arbitrary, but I think the order is critical. I determined
% this value from running the max, min, nans commands (commented out) at
% two different orders of power that either crash or run the speckle. I
% suspect it is realated to the limits on a 'single'.
% realmax('single')
% realmax('single')
Y(Y<1.6430e-04)= 1.6430e-04; 
%==================================
%maxY = max(max(max(Y)))
%minY = min(min(min(Y)))
%myYNans = find(Y==isnan(N));
P = rand(size(Y));
nBinInvFunc = @prob.NegativeBinomialDistribution.invfunc;
N_speckle=feval(nBinInvFunc,P,M,Y);
%display('The speckle is acutually working')
%N_speckle=icdf('nbin',P,M,Y); original code
end


N_speckle(isnan(N_speckle)) = 0; % Replace NaN with Zero


end
function [result2D] = ULR08_decision(data, t, myDim, n_h2o)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ====Description================================
% This function attempts to reconstruct the scene based on the calculted
% power that will be received at the photodetector array.  It uses the TOF
% that corresponds to the maximum power of each photodetector to determine
% the ranges.
% ==================Variables====================
% data              % the noisy data
% t                 % TOF vector of time samples within the range gate
% myDim             % the spatial dimension of the noisy data
% n_h2o             % the index of refraction for water
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ====Code======================================================

result2D = zeros(myDim, myDim);    % Allocate memory

for xi = 1:myDim;
    for yi = 1:myDim;
    tSig = squeeze(data(yi,xi,:));

    % Results
    TOF = t(tSig==max(tSig));
    % If two equal max values are found, use the first one...
    TOF=TOF(1); 
    dis = TOF*(3e8/n_h2o)/2;
    result2D(yi,xi) = dis;
    end;
end;


end
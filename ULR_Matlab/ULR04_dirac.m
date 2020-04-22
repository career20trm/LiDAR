function [T_p, T_p_x, T_p_y, T_p_z] = ULR04_dirac(Rmin, target_area, rho_t, myDim, t, range, dxx, n_h2o)
% ==================Description==================
% The output, T_p, is known as the target profile for LADAR.  It is a dirac
% that is created for use in the convolution of the laser pulse energy with
% the surfaces in the target_area.
% ==================Variables====================
% Rmin              % Range gate minimum distance
% target_area       % Area that represents the scene within the FOV
% rho_t             % reflectivity
% myDim             % sample dimension of distant_array
% t                 % TOF vector of time samples within the range gate
% range             % vector of the range gate sample distances
% dxx               % the differential of the target_area
% n_h2o = 1.33      % Index of refraction for water
% ==================Future Work==================
% The values of refectivity in rho_t COULD be assigened to the dirac
% instead of one, or reflectivity COULD be applied to the power calc.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

% ====Dirac Target Profile=================
T_p=zeros(myDim, myDim, max(size(t))); % Preallocation of memory
T_p_x = [];
T_p_y = [];
T_p_z = [];
dHf = (myDim+1)/2;
for xi=1:myDim;
    for yi=1:myDim;
% THERE WAS A MAJOR ERROR IN THE CODE PROVIDED BY THE TEXT BOOK.
% THE PROBLEM APEARS IN THE TARGET PROFILE DETERMINING THE indxx VALUE!
% +Rmin because we are finding an index value in T_p not a
% range. The error caused the entire scene to be scaled incorrectly!
        tAprox = abs(t-((target_area(yi,xi)+Rmin)*2/(3e8/n_h2o)));
        indxx = find(tAprox==(min(tAprox)))+1; % Locate the range vector index
% Assign a dirac based on target reflectivity and area of spatial sample        
        T_p(yi,xi,indxx)= 1;

% Now create scatter plot vectors of the dirac for viewing output
        T_p_x = [T_p_x (xi-dHf)*dxx];
        T_p_y = [T_p_y (yi-dHf)*dxx];
        T_p_z = [T_p_z range(indxx)];

    end;
end;
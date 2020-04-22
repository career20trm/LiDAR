function [attenCoef, currentVersion, classTxt] = ULR05_ocean(oceanClass)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This function provides the attenuation coefficient for the body of water
% that was specified by the user.
% ==================Variables====================
% oceanClass        % the name of the type of water
% ==================Future Work==================
% CURRENT LIMITATION: only meditterranean sea in deep water is real value.
% Updated the if statement for other bodies of water.
% 
% There should be a statistical method of calculating the atenuation
% coefficient based on the known density of absorbing and scattering
% particles found in specific waters.  This could also include a model that
% considers colored decaying organic matter (CDOM) or flourescing
% compounds.  
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ====Code======================================================

currentVersion = ...
    'Ocean Model currently uses Beer-Lambert law for attenuation due to absorption and scattering. \n ';

% If we ignore scattering, we can equate the linear attenuation coefficient
% with the linear absorption coefficient

if strncmpi(oceanClass, 'Mediterranean Sea', 3)
    classTxt = ['The Mediterranean Sea has the best light!']
    attenCoef = .0222 % Depends on class of water [atten/m]    
elseif strncmpi(oceanClass, 'Cantabric Sea',3)
    classTxt = ['I love fish from the Cantabric Sea!']
    attenCoef = .05 % Depends on class of water [atten/m]      
elseif strncmpi(oceanClass, 'Atlantic Ocean',3)
    classTxt = ['The Atlantic Ocean is the big blue wet thing between me and my home.']
    attenCoef = .05 % Depends on class of water [atten/m] 
elseif strncmpi(oceanClass, 'Antarctic Sea', 3)
    classTxt = ['Penguins like the cold waters of the Antarctic Sea.']
    attenCoef = .05 % Depends on class of water [atten/m]
elseif strncmpi(oceanClass, 'Pacific Ocean',3)
    classTxt = ['Malibu is on the Pacific Ocean.']
    attenCoef = .05 % Depends on class of water [atten/m]   
elseif strncmpi(oceanClass, 'turbid',3)
    classTxt = ['Turbid Water is yucky.']
    attenCoef = .5 % Depends on class of water [atten/m] 
elseif strncmpi(oceanClass, 'class1', 6)
    classTxt = ['Class1']
    attenCoef = .01 % Depends on class of water [atten/m]
elseif strncmpi(oceanClass, 'class2', 6)
    classTxt = ['Class2']
    attenCoef = .05 % Depends on class of water [atten/m]
elseif strncmpi(oceanClass, 'class3', 6)
    classTxt = ['Class3']
    attenCoef = .05 % Depends on class of water [atten/m]    
elseif strncmpi(oceanClass, 'test1', 5)
    classTxt = ['test1']
    attenCoef = -(log(.8))/15 
    % use this only for valication test at Z = 15
elseif strncmpi(oceanClass, 'test2', 5)
    classTxt = ['test2']
    attenCoef = -(log(.5))/15 
    % use this only for valication test at Z = 15
elseif strncmpi(oceanClass, 'test3', 5)
    classTxt = ['test3']
    attenCoef = -(log(.2))/15 
    % use this only for valication test at Z = 15

else 
    classTxt = [ 'No Ocean model was selected, so no attenuation.']
    attenCoef = 0 % Depends on class of water [atten/m]
end


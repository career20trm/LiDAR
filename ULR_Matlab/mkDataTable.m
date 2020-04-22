% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% A script that makes a report on the radiometric quantities that are
% calculated at various points in the ULR program.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.

%% ====Calculate Radiometric Quantities===========================
% 'preG' and 'postG' imply before and after Gain is applied
preGTotE = sum(preGSig); 
postGTotE = sum(postGSig); 
photonsIn = pulseE/(h*v);
phOutPreG = preGTotE/(h*v);
phOutPostG = postGTotE/(h*v);
preGLosses = preGTotE/pulseE;
postGLosses = postGTotE/pulseE;

tot_DisArray = real(sum(sum(abs(distant_array.^2))));
tot_E_t = sum(sum(E_t));
% total Power in 'P_t' data set
totP_P_t = sum(sum(sum(P_t))); 
% total energy in 'P_t' data set; for validation of energy in laser pulse
totE_P_t = sum(squeeze(sum(sum(P_t)))*deltat); 
tot_T_p = sum(sum(sum(T_p)));

tot_P_conv = sum(sum(sum(P_conv)));
tot_I_target = sum(sum(sum(I_target)));
tot_P_ref = sum(sum(sum(P_ref)));
tot_I_receiver = sum(sum(sum(I_receiver)));
tot_P_rec = sum(sum(sum(P_rec)));

totE_N_thermal = sum(sum(sum(N_thermal)))*h*v;
totE_N_back = sum(sum(sum(N_back)))*h*v;
% Signal is contained in 'N_speckle'
totE_N_speckle = sum(sum(sum(N_speckle)))*h*v;

tot_data = sum(sum(sum(data)));

%% =======Prepare Table Data=========================================
columnname = {...   % Column Headers for the table
    'Parameter', 'Value', 'Units', 'dB(value)', 'Units'};
columnformat = {... % Column data types for the table
    'char', 'numeric',  'char', 'numeric',  'char'}; 
colWidths = {150,100,60,110,100};

cellArray =  {... % Create a cell array for the table
'Energy In ',       pulseE,     '[Joules]',	10*log10(pulseE),   	'dB[Joules]';...   
'Photons In',       photonsIn,  '[counts]',	10*log10(photonsIn),  	'dB[Counts]';...   
'Sum(distant_array) ',tot_DisArray,'[Joules]',10*log10(tot_DisArray),'dB[Joules]';...
'Sum(E_t) ',        tot_E_t,    '[Joules]',	10*log10(tot_E_t),   	'dB[Joules]';...
'Sum(P_t) ',        totP_P_t,   '[Watts]',	10*log10(totP_P_t),   	'dB[Watts]';...
'Sum(P_t)*time ',  	totE_P_t,  	'[Joules]',	10*log10(totE_P_t),   	'dB[Joules]';...
'Sum(T_p) ',        tot_T_p,  	'[impulses]',10*log10(tot_T_p),  	'dB[impulses]';...
'Sum(tot_P_conv)',  tot_P_conv, '[Watts]',	10*log10(tot_P_conv),	'dB[Watts]';...
'Sum(tot_I_target)',tot_I_target,'[Watts/str]',	10*log10(tot_I_target),'dB[Watts/str]';...
'Sum(tot_P_ref)',   tot_P_ref,  '[Watts]',	10*log10(tot_P_ref),	'dB[Watts]';...
'Sum(tot_I_receiver)',tot_I_receiver,'[Watts/str]',10*log10(tot_I_receiver),'dB[Watts/str]';...
'Sum(tot_P_rec)',   tot_P_rec,  '[Watts]',	10*log10(tot_P_rec),	'dB[Watts]';...

'Thermal Noise ',totE_N_thermal,'[Joules]',  10*log10(totE_N_thermal),  'dB[Joules]';...   
'Background Noise ',  G*totE_N_back, '[Joules]',  10*log10(G*totE_N_back),'dB[Joules]';...   
'Speckle Noise ',G*totE_N_speckle,'[Joules]',10*log10(G*totE_N_speckle),'dB[Joules]';...   

'Energy Out ',      preGTotE,   '[Joules]',	10*log10(preGTotE),   	'dB[Joules]';...   
'Energy Out  +G ',	postGTotE,	'[Joules]',	10*log10(postGTotE),  	'dB[Joules]';...   
'Photons Out ',     phOutPreG,  '[counts]',	10*log10(phOutPreG),  	'dB[Counts]';...   
'Photons Out +G ',	phOutPostG,	'[counts]',	10*log10(phOutPostG), 	'dB[Counts]';...   
'Losses ',          preGLosses, '[ratio]',	10*log10(preGLosses),	'dB';...   
'Losses +G ',       postGLosses,'[ratio]',	10*log10(postGLosses),	'dB';}

%% =======Figure Setup===============================================
set(0,'DefaultFigurePaperType','A4');
figDim = [2100 2970]*1.5;           % [px] dimensions of figures
set(0,'Units','pixels');            % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector
myTable = figure('Position',[1800 400 540 500]); 
%myTable = figure('Position',[1800 400 540 500]); 
%set(gcf,'units','inches','outerposition',[1800 400 540 500]);
set(myTable, 'PaperPositionMode', 'auto'); %WYSIWYG



%% =========Make Figure of Table Data================================
%myTable = figure('Position',[1800 400 540 500]); 
    %[[posn-screen] [size]]
    %[[posn-figure] [size]]
uitable('parent', myTable,...
    'Units','pixel',...
    'Position', [10 10 520 480],...
    'Data', cellArray,... 
    'ColumnName', columnname,...
    'ColumnFormat', columnformat,...
    'ColumnWidth', colWidths,...
    'RowName',[],...
    'Fontsize', 14); 

%====SAVE=====
saveas(myTable, 'reports/images/tableData','eps2');
saveas(myTable, 'reports/figures/tabledata','fig');



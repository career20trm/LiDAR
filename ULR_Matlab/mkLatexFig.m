function [] = mkLatexFig(myFig, figDim, fScale, axScale)
% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This function is for resizing the fonts and dimensions of figures. It can
% be useful for quickly adjusting figures that will be used in Latex
% documents
% ==================Variables==================
% myFig = handle;     % handle of figure to change
% figDim = [500 400]; % desired dimensions of the figure
% fScale = 16;        % fontsize of text in figure
% axScale = 16;       % fontsize of numbers and tics on all axis
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ===Code=======================================

%% =====Set dimensions
% A4 dimensions are [21.0 29.7] cm   [8.27 11.69] inches
set(0,'DefaultFigurePaperType','A4');% [px] dimensions of figures
set(0,'Units','pixels');            % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector

set(myFig,'Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) figDim],...
    'units','inches',...
    'outerposition',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) 8.27 11.69],...
    'PaperPositionMode', 'auto'); %WYSIWYG


%% =====Set fonts
a = findall(gcf);
b = findobj(gcf);
c = findall(b,'Type','text') ;
% returns the xlabel handle twice
d = findobj(a,'Type','text');
% can't find the xlabel handle

set(c, 'fontsize', fScale);
set(d, 'fontsize', fScale);

%% =====Set Axes
a = findall(gcf);
b = findobj(gcf);
c = findall(b,'Type','axes') ;
% returns the xlabel handle twice
d = findobj(a,'Type','axes');
% can't find the xlabel handle

set(c, 'fontsize', axScale);
set(d, 'fontsize', axScale);


saveas(myFig, 'reports/latex/report_A4','eps2');
saveas(myFig, 'reports/latex/report_A4','fig');


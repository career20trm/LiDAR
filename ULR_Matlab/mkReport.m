% ====Author==================================================== 
% Thomas Morris, Summer 2014 - UPC Barcelona
% This document is part of a Master's Thesis Project 
% that largely followed the instruction given in these texts: 
% "Direct-Detection LADAR Systems" by Richmond and Cain
% "Ocean Sensing and Monitoring" by Hou
% This work is being published for non-commercial, academic uses only. 
% There is no warranty for this software.
% ==================Description==================
% This script is for creating visualizations of data that result from
% running the ULR program.  It includes the temporal, spatial, scene,
% moment, detector energy, reconstructed scene, SNR, SNR 5std, sample
% signal at 2,2 and sample signal at 24,24.
% ==================Credit=======================
% This is part of the thesis work of Thomas Morris, photonics@trmorris.com
% It was developed following the book, "Direct Detection LADAR Systems," by 
% Richmond and Cain as an instructional guide.  This work is intended to be
% an open source utility for educational purposes.
%% ====Code======================================================
% A4 dimensions are [21.0 29.7] cm   [8.27 11.69] inches
set(0,'DefaultFigurePaperType','A4');
figDim = [800 1200];           % [px] dimensions of figures
set(0,'Units','pixels');            % set screen units
myScreen = (get(0,'ScreenSize'));   % screen resolution vector

%% =======Figure 1===============================================
reportFig = figure('Position',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) figDim]); 
set(gcf,'units','inches','outerposition',[(myScreen(:,3)*0.7) (myScreen(:,4)*0.1) 8.27 11.69]);
set(reportFig, 'PaperPositionMode', 'auto'); %WYSIWYG
axis equal;

%====
axTemporal = subplot(321);
plot(t, pulseSig);

%axis([X1, X2, Y1, Y2]);
%n=get(gca,'xtick');
%set(gca,'xticklabel',sprintf('%.4f |',n'));

    xlim([((Z-1)*2/(3e8/n_h2o)) ((Z+1)*2/(3e8/n_h2o))]);
    xlabel('time [s]', 'fontsize', 12);
    ylabel('Pulse Energy [J] ', 'fontsize', 12);
    title(['(a) Temporal Gaussian Pulse' ' = ' num2str(pulseE)...
        ' [J] \newline '], 'fontsize', 12);
%====
axPower = subplot(322);
imagesc((1:sz)*dx,(1:sz)*dx,abs(beam))

myMax = max(max(abs(beam)));
myMin = min(min(abs(beam)));
caxis([myMin myMax]);
    colorbar('Visible','on', 'location', 'EastOutside'); 
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
    title(['(b) Spatial Gaussian Pulse = ' num2str(pulseE)...
        ' [J] \newline Distribution at Laser Cavity'], 'fontsize', 12);
%====
axScene = subplot(323);
imagesc((1:myDim)*dxx,(1:myDim)*dxx,(target_area+Z))
%image(target_area, 'CData',target_area,'CDataMapping', 'scaled');
orgMax = max(max(target_area+Z));
orgMin = Z;
caxis([orgMin orgMax]);
    colorbar('Visible','on', 'location', 'EastOutside'); 
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
    title(['(c) Scene' frqStr ...
        ' \newline RangeGate = ' num2str(orgMin) ' - '...
        num2str(orgMax) ' [m] '], 'fontsize', 12);   %'interpreter', 'tex');    
%====  later try dividing the CLim by vidScale for setting range
axPower = subplot(324);
% Pick the best index for each report
imagesc((1:myDim)*dxx,(1:myDim)*dxx,P_rec(:,:,moment))
%image(P_rec(:,:,moment), 'CData',P_rec(:,:,moment),'CDataMapping', 'scaled');
myMax = max(max(max(P_rec(:,:,:))));
myMin = min(min(min(P_rec(:,:,:))));
caxis([myMin myMax]);
    colorbar('Visible','on', 'location', 'EastOutside'); 
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
    title(['(d) Moment in time = ' num2str(t(moment))...
        ' [s] \newline '], 'fontsize', 12);
%        ' [s] \newline Max pixel power = ' num2str(myMax) ' [W] '
%====
axSignal = subplot(325);
plot(t, postGSig);
    % Finds time index at distance Z; because scene begins at Z!
    xlim([minT maxT]);
    ylim([0 max(postGSig)]);
    xlabel('TOF [s]', 'fontsize', 12);
    ylabel('Detector Energy [J] ', 'fontsize', 12);
    title(['(e) Total Signal Energy = ' num2str(postGTotE)...
        ' [J] \newline '], 'fontsize', 12); 
%====
axResult = subplot(326);
imagesc((1:myDim)*dxx,(1:myDim)*dxx,(result2D))
%image((result2D-Z), 'CData',(result2D-Z),'CDataMapping', 'scaled');
    % Use the original scene colorscale for comparison!
    caxis([orgMin orgMax]);
    colorbar('Visible','on', 'location', 'EastOutside'); 
    xlabel('x-FOV [m]', 'fontsize', 12);
    ylabel('y-FOV [m]', 'fontsize', 12);
    title(['(f) Resulting Scene \newline RangeGate = ' num2str(orgMin) ' - '...
        num2str(orgMax) ' [m] '], 'fontsize', 12);     

%====SAVE=====
saveas(reportFig, 'reports/images/report_A4','eps2');
saveas(reportFig, 'reports/figures/report_A4','fig');

%% =======Figure 2===============================================
%figDim = [800 1200];           % [px] dimensions of figures
reportFig = figure('Position',[(myScreen(:,3)*0.2) (myScreen(:,4)*0.1) figDim]); 
set(gcf,'units','inches','outerposition',[(myScreen(:,3)*0.2) (myScreen(:,4)*0.1) 8.27 11.69]);
set(gcf, 'PaperPositionMode', 'auto'); % !!!WYSIWYG!!!
px = 2;
subplot(411);%
pxE_noise = (squeeze(data(px,px,:)))*h*v;
plot(t,pxE_noise);
xlim([minT maxT]);
xlabel('TOF [s]', 'fontsize', 12);    
ylabel('Sample Energy [J] ', 'fontsize', 12);
title(['(a) Noisy sample at   x = y = '...
    num2str(px)], 'fontsize', 12);    

px = floor(myDim-1)/2;
hold on
subplot(412);%
pxE_resolved = (squeeze(data(px,px,:)))*h*v;
plot(t,pxE_resolved);
xlim([minT maxT]);
xlabel('TOF [s]', 'fontsize', 12);    
ylabel('Sample Energy [J] ', 'fontsize', 12);
title(['(b) Resolved sample at   x = y = '...
    num2str(px)], 'fontsize', 12);   

subplot(4,1,3:4);%
imagesc((1:myDim)*dxx,(1:myDim)*dxx,SNR);
axis image;
xlabel('x-FOV [m]', 'fontsize', 12);
ylabel('y-FOV [m]', 'fontsize', 12);
myMax = mean(std(SNR))*5;
mytitle = 'Colorbar shows 5 standard deviations of sample SNR ';
if myMax<5
    myMax = 5;
    mytitle = '(c) Colorbar shows sample SNR between 0 and 5 because signal is low ';
end
caxis([0 myMax]);
colorbar('Visible', 'on', 'location', 'EastOutside'); 
title(mytitle, 'fontsize', 12);  

%% =======Figure 3===============================================
% Figure with 5 STD of SNR
figure;
imagesc((1:myDim)*dxx,(1:myDim)*dxx,SNR)
axis image;
xlabel('x-FOV [m]', 'fontsize', 12);
ylabel('y-FOV [m]', 'fontsize', 12);
myMax = max(max(SNR));
caxis([0 myMax]);
colorbar('Visible', 'on', 'location', 'EastOutside'); 
title(['SNR for every sample in detector '], 'fontsize', 12);  


function [distant_array, figDisArr, dxx, myDim] = ULR02_beamFar(w_o, Z, lam, dx, zoom, msSTD, sz, beam)
%% ====Description===============================================
% 
%% ====Variables=================================================
% 
%% ====Future Development========================================
% 
%% ====Code======================================================
%dxx = (sqrt(2)*lam*Z)/(6*w_o)*0.5; % Equation3.10
%zFactor = exp(Z)/Z;% the basis of the distant_array formula
stdBeam = w_o*(sqrt(1+(Z*lam/(pi*(w_o^2)))^2))/sqrt(2);
% alternatively I could use one vector from the middle of the array taken
% from the equation below to determine the std
% zoomD = 1;
dxx = stdBeam/(msSTD*2)% msSTD*2 = numSamples/Standard Deviation
dimZoom = round(msSTD*6*zoom);% beam width approx 6 STD wide
xBeam = (-dimZoom:1:dimZoom)*dxx;
myDim = dimZoom*2+1
%============================================
distant_array=zeros(myDim,myDim);
j=sqrt(-1);
myDimHf = (myDim+1)/2;
szHf = (sz+1)/2;

if Z<49% like code in beamNear
    [x, y] = meshgrid(xBeam,xBeam);
    beamAmp = 1;
    beam = beamAmp*exp(-(x.^2+y.^2)/(w_o^2)); % Equation 3.9
    beam(1,1) = 0;% comparable colormaps regardless of dimension or scale
    distant_array = beam;

else % Equation 3.5 Rayleigh-Sommerfield Propagation
for xx=1:myDim
    xxc=(xx-myDimHf)*dxx;
    for yy=1:myDim;
        yyc=(yy-myDimHf)*dxx;
        for x=1:sz;
            xc=(x-szHf)*dx;
            for y=1:sz;
                yc=(y-szHf)*dx;
        R=sqrt(Z^2+(xc-xxc)^2+(yc-yyc)^2);
        distant_array(yy,xx)=distant_array(yy,xx)+dx*dx*Z*beam(y,x).*exp(2*pi*j*R/lam)/(j*lam*R^2);
            end;
        end;
    end;
end;
end

figDisArr = figure
norm_factor= sqrt(sum(sum(abs(distant_array).^2)));
distant_array=distant_array.*ones(myDim,myDim)/norm_factor;
imagesc((1:myDim)*dxx,(1:myDim)*dxx,abs(distant_array));% plots as an image
colorbar

ylabel('METERS');
xlabel('METERS');



end


function [myGauss] = gaussGen(sigma, size);
X = -size:size;
%missing factor of:  1/(sqrt(2*pi)*sigma)
myGauss = exp(-0.5*X.^2/(sigma^2)); 
%figure(10);
%plot(X,myGauss)

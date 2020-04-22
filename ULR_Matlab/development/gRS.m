function out = gRS(lambda,z_p)


[X Y Z] = meshgrid(x,y,z);

r = sqrt(X.^2 + Y.^2 + Z.^2);

out = exp(1i.*k.*r).*(-1i.*k).*(z./r)./(2.*pi.*r).*sqrt(lambda.*z_p);

end
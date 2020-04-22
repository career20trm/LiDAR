colormap hsv;
colorbar('Location', 'EastOutside');
caxis([1000 1020]);

set(gca, 'Color', [0 0 0]);
set(gca, 'Xlim', [-ms ms]);% NOTE!!!!!THESE CORRESPOND TO THE R-HAND RULE
set(gca, 'Ylim', [-ms ms]);% WITH THE XLIM ON THE "LEFT-RIGHT PROPAGATION
set(gca, 'Zlim', [range_min range_max]);% REGARDLESS OF THE X....? think of this
set(gca, 'XColor', [.2 .2 .2]);
set(gca, 'YColor', [.2 .2 .2]);
set(gca, 'ZColor', [.2 .2 .2]);
set(gca, 'CameraPosition', [20*ms -2*ms -2*ms]);

mydim = sqrt(length(z))



%NOTE THAT MESH AND SURF DOES NOT CONNECT THE POINTS CORRECTLY
myMesh = [];
for i = 1:mydim;
    l = (mydim*(i-1))+1;
    r = (mydim*i);
    row = z(l:r);
    myMesh = [myMesh row(:)];
end;


ms = 50;
a = meshgrid(-ms:ms);
b = a';
load('array2D')
figure
scatter3(a(:),b(:),array2D(:))
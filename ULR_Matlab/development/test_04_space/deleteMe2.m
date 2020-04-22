clear all; close all;

%load('array2D_original');
%======2D Graph and settin gs======
figure;
hold on;
grid on;
cla;

ms = (4*25-1)/2;% Even number of points. Omits the zero data pt.
arrayMs = -ms:1:ms;  % The range of x values. "1:1" ensures even number
mySize = length(arrayMs);

% 2D parabola generator
[a b] = meshgrid (arrayMs); % This generates the actual grid of x and y values.
array2D=(a.^2+b.^2)*.1 +500; % Note the elementwise notation


%array2D = ones(100)+50
image(array2D, 'CDataMapping', 'scaled');% golden!!!
axis image;
axis off;

%colormap;
colorbar('clim', [0 500],'Location', 'EastOutside');
msize = size(array2D(1,:));
range_min = min(array2D(:));
range_max = max(array2D(:));
caxis([range_min range_max]);
set(gca, 'Color', [0 0 0]);
%set(gca, 'Xlim', [1 mySize]);% NOTE!!!!!THESE CORRESPOND TO THE R-HAND RULE
%set(gca, 'Ylim', [1 mySize]);% WITH THE XLIM ON THE "LEFT-RIGHT PROPAGATION
set(gca, 'XColor', [.2 .2 .2]);
set(gca, 'YColor', [.2 .2 .2]);


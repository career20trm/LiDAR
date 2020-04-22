% Ladar complete Simulation for single point

%clear all; close all;
%scanScene;
clear all; close all;tic
load('newScene');
for cell_x = 1:1%size(newScene(1,:)) 
    for cell_y = 1:1%size(newScene(:,1))
        load('newScene');
        x_posn = newScene{cell_y, cell_x}(1); % x value
        y_posn = newScene{cell_y, cell_x}(2); % y value
        % skip the x,y pair contained in first two values below
        mySurfs = newScene{cell_y, cell_x}(3:end); 
        % Creates the time signal for all surfaces below
        ch2_sigGen_T_p_Noise_scanScene; 
        decision;
        arrayOut{cell_y, cell_x}(1) = x_posn; % x value
        arrayOut{cell_y, cell_x}(2) = y_posn; % y value
        arrayOut{cell_y, cell_x}(3:end) = data;
        save('arrayOut','arrayOut')
        
    end
end
toc

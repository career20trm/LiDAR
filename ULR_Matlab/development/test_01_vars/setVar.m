%  This script enables a single function to be written for testing.  It
%  handles all of the plotting differences as well as the vectorization of
%  the particular variable that is being tested.
%global varUnits varNameTex x_scale

switch varName
    case 'P_avg'
        P_avg = varTest;        % Vectorize the variable for testing
        varUnits = '[W]';       % Units for displaying on graph
        varNameTex = 'P\_avg';  % Writes varName in LaTex
        x_scale = 'linear';     % Only necessary for 'log' variables
        
    case 'PRF'
        PRF = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'PRF';
    case 'Pulse_width'
        Pulse_width = varTest;
        varUnits = '[s]';
        varNameTex = 'Pulse\_width';
    case 'True_range'
        True_range = varTest;
        varUnits = '[m]';
        varNameTex = 'True\_range';
    case 'ap_diameter'
        ap_diameter = varTest;
        varUnits = '[m]';
        varNameTex = 'ap\_diameter';
    case 'delta'
        delta = varTest;
        varUnits = '[?a.u.?]';
        varNameTex = 'delta';
    case 'quantum_eff'
        quantum_eff = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'quantum\_eff';
    case 'reciever_focal'
        reciever_focal = varTest;
        varUnits = '[?a.u.?]';
        varNameTex = 'reciever\_focal';
    case 'rho_t'
        rho_t = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'rho\_t';
    case 'tau_atm'
        tau_atm = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'tau\_atm';
    case 'tau_opt'
        tau_opt = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'tau\_opt';
    case 'theta_r'
        varUnits = '[radians]';
        theta_r = varTest;
        varNameTex = 'theta\_r';
        varUnits = '[a.u.]';
    case 'theta_t'
        theta_t = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'theta\_t';
    case 'v'
        v = varTest;
        varUnits = '[Hz]';
        varNameTex = 'v';
% apdGain Variables below here
    case 'G'
        G = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'G';
        gBool = true;
    case 'M'
        M = varTest;
        varUnits = '[a.u.]';
        varNameTex = 'M';
        gBool = true;
    case 'S_irr'
        S_irr = varTest;
        varUnits = '[?W/(m^{2}Hz)?]';
        varNameTex = 'S\_irr';
        gBool = true;
    case 'delta_lam'
        delta_lam = varTest;
        varUnits = '[?m?]';
        varNameTex = 'delta\_lam';
        gBool = true;
    case 'i_dark'
        i_dark = varTest;
        varUnits = '[A]';
        varNameTex = 'i\_dark';
        gBool = true;
    case 'T'
        T = varTest;
        varUnits = '[K]';
        varNameTex = 'T';
        gBool = true;
    case 'C'
        C = varTest;
        varUnits = '[F]';
        varNameTex = 'C';
        x_scale = 'log';
        gBool = true;
    case 'trials'
        %P_avg = P_avg*(ones(1,varTest));% not efficient code
        % because it calculates the same thing #varTest times
        trials = trials;%varTest;
        varUnits = ' ';
        varNameTex = 'Trials';
    otherwise
        disp(['No such variable as "' varName '"'])
        disp('---------------------------------------------------------');
        disp('Press ctr-c within 10 seconds or program will continue...');
        pause(3);
        disp('              ...to build an army for world domination.');
        disp('---------------------------------------------------------');
        pause(7);
        disp('The minions await thy command...');
end
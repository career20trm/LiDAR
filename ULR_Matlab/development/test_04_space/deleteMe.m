clear all; close all;
tic
arrayOut= [];
mySurfs= [990 1000 1005 1010];  
ch2_sigGen_T_p_Noise_noPlot; 
hello = 3
    smoothData = mkSmooth(data, 2, 10);
    TOF = t(find(smoothData==max(smoothData)));
    arrayOut = [arrayOut; [TOF smoothData]];
    save('arrayOut','arrayOut')
    toc
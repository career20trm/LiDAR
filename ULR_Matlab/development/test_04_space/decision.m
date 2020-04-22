%% Decision

i_max = find(smoothData==max(smoothData))

TOF = t(i_max)
Distance1 = t(i)*0.15
Distance2 = t(i)*3e8
%% ======Work in Progress=====may be useless for decision
% TRM.... I made this up for lack of anything else...at this point.
%cutSig = smoothData-(max(smoothData)*0.2);% removes the bottom 20% of the signal
%totAfterCut = sum(cutSig); % total photon count above 20%
%normFactor = totAfterCut/length(cutSig)% factor to normalize by
%normCutSig = cutSig/normFactor

%if max(cutSig)

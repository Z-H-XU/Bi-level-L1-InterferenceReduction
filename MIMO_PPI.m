% --------------------------------------------------------------------------------------------------
%
%    Demo software for Interference Reduction on Millimeter Wave Radars
%                  Using Bi-level L1 Optimization
%
%                   Release ver. 2.0  (Aug. 1, 2022)
%
% --------------------------------------------------------------------------------------------
%
% authors:              Zhi-huo Xu.
%
% web page:           https://github.com/Z-H-XU/Bi-level-L1-InterferenceReduction
%
% contact:               xuzhihuo@gmail.com
%
% --------------------------------------------------------------------------------------------
% Copyright (c) 2022 NTU.
% Nantong University, China.
% All rights reserved.
% This work should be used for nonprofit purposes only.
% --------------------------------------------------------------------------------------------
% If you use the code, please kindly cite the following paper:  
% Zhihuo Xu: Bi-level L1 Optimization Based Interference Reduction for Millimeter Radars. IEEE Transactions on Intelligent Transportation Systems, Under 2nd review.
% Thank you?

c0=3e8;
rmid=1;rmxd=256;
R_idx=rmid:rmxd;
Ridx=c0/2/para.FrequencySlope*(-R_idx+rmxd/2)*(para.SampleRate/para.numADCSamples);

fac=4;
AzNfft=1024*fac;

rafData=fftshift(fft(dbfData,[],1),1);

rafData=rafData(R_idx,:);

data=fftshift(fft(rafData,AzNfft,2),2);
az=linspace( 1,-1,AzNfft);
azz=acosd(az)-90;

Xr=Ridx'*cosd(azz);
Yr=Ridx'*sind(azz);
pcolor(Yr,Xr,20*log10(abs(data)+eps));shading interp
axis;
xlim([-50    50]);
ylim([0    50]);
colormap(jet);shading interp 
h=colorbar;
caxis([30 90]);
title(h,'dB')
xlabel('X (m)');
ylabel('Y (m)');

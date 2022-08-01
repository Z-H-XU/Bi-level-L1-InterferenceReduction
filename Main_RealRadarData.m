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

clc;clear;close all;

load('RealRadarData.mat');

c0=3e8;
rmid=1;rmxd=256;
CPI=para.chirps;

fd=-para.prf/2:para.prf/CPI:para.prf/2-para.prf/CPI;
velocity=-para.lambda*fd/2;
R_idx=rmid:rmxd;
Ridx=c0/2/para.FrequencySlope*(-R_idx+para.numADCSamples/2)*(para.SampleRate/para.numADCSamples);


    

M=para.numADCSamples;
    
biA1 = @(x) x;
biA1T = @(x) x;
p1 = 1.0;

N = 2.0*M;
biA2 = @(x) invTransform(x,M,N)/sqrt(N);
biA2T = @(x) Transform(x,M,N)/sqrt(N);
p2 = N*1.0;
Nit=20;
plot_flag='nplots';

for chirp_num=1:para.chirps
    x=Rawdata(:,chirp_num);
    ai=1;
    at=2;
    lami=1*mean(abs(x));
    lamt=lami/3;
    [si, st, cost] =bilevel_ISTA(x, biA1, biA1T, biA2, biA2T, lami, lamt, ai, at, Nit, plot_flag);
    data_reduce(:,chirp_num)=st;
end


gdata=fftshift(fft(GroundTruth,[],1),1);
gdata=fftshift(fft(gdata,[],2),2); 
figure
surf(velocity,Ridx,20*log10(abs(gdata)+eps))
title('Interference free (Ground truth)');
pnum=2;Plots_Setting;


interference=fftshift(fft(Rawdata,[],1),1);
interference=fftshift(fft(interference,[],2),2); 
figure
surf(velocity,Ridx,20*log10(abs(interference)+eps))
title('Interference');
pnum=2;Plots_Setting;



new_datar=fftshift(fft(data_reduce,[],1),1);
new_data=fftshift(fft(new_datar,[],2),2); 
figure
surf(velocity,Ridx,20*log10(abs(new_data)+eps))
title('Interference reduction');
pnum=2;Plots_Setting;
    
 



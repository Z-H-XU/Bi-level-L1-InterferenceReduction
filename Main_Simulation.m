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

clc;clear;
close all;

load('SimulatedData.mat');

c0=3e8;
dletaR=ADCFs/N_Fast*3e8/2/ChirpRate;
idR=dletaR*[0:N_Fast/2-1];
idt = 1e6*(0 : 1/ADCFs : PRI-1/ADCFs);

x=Rawdata(1,:);
M = length(x);                    % M : length of signal


biA1 = @(x) x;
biA1T = @(x) x;
p1 = 1.0;

N = 2.0*M;
biA2 = @(x) invTransform(x,M,N)/sqrt(N);
biA2T = @(x) Transform(x,M,N)/sqrt(N);
p2 = N*1.0;

Interation=30;
plot_flag='nplots';
ai=2;
at=3.5;

    
for k=1:CPI
    
    x=Rawdata(k,:);
   
       
    lami=0.5*mean(abs(x));
    lamt=lami/1.1;
 
    

    [si, st, cost] =bilevel_ISTA(x.', biA1, biA1T, biA2, biA2T, lami, lamt, ai, at, Interation, plot_flag);
    
    data_reduce(:,k)=st;
    
end
 

R_idx=0:M-1;
Ridx=c0/2/ChirpRate*(-R_idx+M/2)*(ADCFs/M);
    

raw_data=Rawdata.';
raw_data=fftshift(fft(raw_data,[],1),1); % Range FFT
  
raw_data=fftshift(fft(raw_data,[],2),2); % FFT to Range Doppler Domain

raw_data=raw_data(1+M/2:M,:);
R_idx=0:M-1;
Ridx=c0/2/ChirpRate*(-R_idx+M/2)*(ADCFs/M);
    
figure
surf(idV,idR,20*log10(abs(raw_data)+eps)+30)
title('Interference');
pnum=1;Plots_Setting;


new_data=fftshift(fft(data_reduce,[],1),1); % Range FFT

new_data=fftshift(fft(new_data,[],2),2); % FFT to Range Doppler Domain
new_data=new_data(1+M/2:M,:);
figure
surf(idV,idR,20*log10(abs(new_data)+eps)+30)
title('Interference reduction');
pnum=1;Plots_Setting;


load('SimulatedData_interference_free.mat');


raw_data_interference_free=Rawdata_interference_free.';
raw_data_interference_free=fftshift(fft(raw_data_interference_free,[],1),1); % Range FFT
  
raw_data_interference_free=fftshift(fft(raw_data_interference_free,[],2),2); % FFT to Range Doppler Domain

raw_data_interference_free=raw_data_interference_free(1+M/2:M,:);
R_idx=0:M-1;
Ridx=c0/2/ChirpRate*(-R_idx+M/2)*(ADCFs/M);
    
figure
surf(idV,idR,20*log10(abs(raw_data_interference_free)+eps)+30)
title('Interference free (Ground truth)');
pnum=1;Plots_Setting;


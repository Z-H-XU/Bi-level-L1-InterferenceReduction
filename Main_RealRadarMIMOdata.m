% --------------------------------------------------------------------------------------------------
%
%    Demo software for Interference Reduction on Millimeter Wave Radars
%                  Using Bi-level L1 Optimization
%
%                   Release ver. 2.3  (Aug. 1, 2022)
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
% Zhihuo Xu: Bi-level L1 Optimization Based Interference Reduction for Millimeter Radars. IEEE Transactions on Intelligent Transportation Systems, https://doi.org/10.1109/TITS.2022.3215636
% Thank you


clc;clear;close all;

load('RealRadar_MIMO_Data.mat');



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
        
for kk=1:8

    x0=chData(kk,:);
    x=reshape(x0,para.numADCSamples,1);

    ai=1;
    at=2;
    lami=1*mean(abs(x));
    lamt=lami/3;

    [si, st, cost] =bilevel_ISTA(x, biA1, biA1T, biA2, biA2T, lami, lamt, ai, at, Nit, plot_flag);

    data_reduce(kk,:)=st;

end
    
dbfData=gdata';
figure;MIMO_PPI;title('Interference free (Ground truth)');


dbfData=chData';
figure;MIMO_PPI;title('Interference');

dbfData=data_reduce';
figure;MIMO_PPI;title('Interference reduction');
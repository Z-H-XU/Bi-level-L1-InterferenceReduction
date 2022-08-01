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

xlabel(['Velocity (','m/s)']);
ylabel('Range (m)');
zlabel('Intensity (dBm)');

colormap(jet);
shading interp 
colorbar
if(1==pnum)
xlim([-10 20]);ylim([10 35]);zlim([-30 60]);caxis([-40 40]);view(-45,20)
elseif(2==pnum)
xlim([2.2 20]);  ylim([2 20]);zlim([50 100]);caxis([70 100]); view(-32,54);
end

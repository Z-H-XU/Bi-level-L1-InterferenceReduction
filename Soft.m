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

function y = Soft(x, T)
y = max(1 - T./abs(x), 0) .* x;
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


function [si, st, cost] = bilevel_ISTA(y, A1, A1T, A2, A2T, lam1, lam2, ai, at, Nit, plot_flag)

% Author: Zhihuo Xu.
% Date :  27 September, 2021.

if nargout > 2
    COST = true;
    cost = zeros(1,Nit);     % cost function
else
    COST = false;
    cost = [];
end

GOPLOTS = false;
if nargin == 11
    if strcmp(plot_flag,'plots')
        GOPLOTS = true;
    end
end

% Initialize:

ik = 0*A1T(y);
xk = 0*A2T(y);

Ti = lam1/(2*ai);
Tt = lam2/(2*at);

N = length(y);
A = 0.9*max(abs(y));


for k = 1:Nit
    % fprintf('Iteration %d\n', k)
    
    xk=(1-1/at)*xk+1/at*A2T(y-ik);
    xk=Soft(xk, Tt) ;
    
    ik=(1-1/ai)*ik+1/ai*(y-A2(xk));
    ik=Soft(ik, Ti) ;
    
    if COST
        x2 = A2(xk);
        cost(k) =  sum(abs(ik(:)-x2(:)-y(:)).^2)+lam1*sum(abs(xk(:))) + lam2*sum(abs(ik(:)));
    end
    
    if GOPLOTS
        
        x1 = ik;
      
        res = y - ik - x2;
        
        figure(100)
        clf
        subplot(3,1,1)
        plot(real(x1))
        xlim([0 N])
        ylim([-A A])
        title({sprintf('Interation %d',k),'Interfering signal'})
        box off
        subplot(3,1,2)
        plot(real(x2))
        xlim([0 N])
        ylim([-A A])
        box off
        title('Radar target signal')
        subplot(3,1,3)
        plot(real(res))
        xlim([0 N])
        ylim([-A A])
        title('Residual noise')
        box off
        drawnow
    end
    
end

si = A1(ik);
st = A2(xk);

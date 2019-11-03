% Implementation of group sparse SVD for SMM-NICA from [1]
%
%     Copyright (C) 2017 Lala Khadidja Hamaidi
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Contact information of the author (please report bugs):
% goelz@spg.tu-darmstadt.de
% http://spg.tu-darmstadt.de

%%%  REFERENCES %%%
%[1] L. K. Hamaidi, M. Muma, and A. M. Zoubir, “Multi-speaker voice activity
%detection  by  an  improved  multiplicative  non-negative  independent  com-
%ponent analysis with sparseness constraints,” in Proc. of International
%Conference on Acoustics, Speech and Signal Processing (ICASSP), IEEE, 
%2017, pp. 4611–4615.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [u, v, iter] = ssvd_UpdateV(Y,gamv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %The rank-one sparse singular value decomposition (SSVD)
 %  Requirement: thresh.m
 %
 % Input variables:
 %      - Y:            The MxN signal matrix to be decomposed
 %      - gamv_scal :   weight parameter in Adaptive LASSO for the  
 %                      right singular vector, nonnegative constant 
 %                      (default = 0, LASSO)
 %
 % Output variables: 
 %      - Y:    The signal matrix as approximated by its decomposition USV'
 %      - u:    The left sparse singular vector
 %      - v:    The right sparse singular vector
 %      - iter: The number of iterations required to achieve convergence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [M, N]= size(Y);

    thre_v = 1;

    %Initial non-sparse SVD to obtain estimates for U and V
    [U_init, ~, V_init] = svd(Y,'econ');
    %Extract the first columns as we are interested in a rank-one
    %decomposition only
    u0 = U_init(:,1);
    v0 = V_init(:,1);

    %Convergence threshold
    conv_thresh = 10^(-4);
    
    %Maximum number of iterations
    n_iter = 100;

    %Initialization of difference in v between two iteration steps
    v_iter_diff = 1;
    iter = 0;

    %Total sum of squares of signal matrix elements 
    SST = sum(sum(Y.^2));

    %% Sparse update of v
    while (v_iter_diff > conv_thresh)
        iter = iter+1;
        
        %Auxilary variable
        z_v =  Y'*u0;
        
        %Weights to 1 for LASSO
        weights_v = abs(z_v).^(gamv);
        
        %Determine time indeces for which the weight is non-zero
        weights_v_nz_ind = find(weights_v~=0);
        
        %Ordinary least squares estimate of error variance in the sparse
        %optimization problem (Eq. 3.3) with (||Y'*u0||_2)^2 = SST_hat
        rho_squared = (SST - sum(z_v.^2))/(M*N-N);
        
        %For comparison to the threshold in Eq. (3.5)
        t_v = sort([0; abs(z_v.*weights_v)]);

        r_v = sum(t_v>0); %Will serve to replace g(lambda_v) during iteration

        %Initialization of the BIC
        B_v = ones(N+1, 1)*Inf;

        %Computation of the BIC for different values of lambda_v
        for i = 1:r_v
            %Initialization of the current candidate threshold
            l_v_i  =  t_v(N+1-i);
            %Computation of corresponding v
            para = struct('type', thre_v, 'lambda',l_v_i./weights_v(weights_v_nz_ind));            
            gam_tilde = thresh(z_v(weights_v_nz_ind), para);
            v_i = zeros(N,1);
            v_i(weights_v_nz_ind) = gam_tilde;
            %BIC
            B_v(i) = sum(sum((Y - u0*v_i').^2))/rho_squared + i*log(M*N);
        end
        
        %Index at which BIC is maximized
        I_v = find(B_v==min(B_v), 1, 'first');
        %Select optimal lambda
        l_v = t_v(N+1-I_v);
        %Perform the computation of v
        para = struct('lambda',l_v./weights_v(weights_v_nz_ind));
        gam_tilde = thresh(z_v(weights_v_nz_ind),para);
        v1 = zeros(N,1);
        v1(weights_v_nz_ind) = gam_tilde;
        v1 = v1/sqrt(sum(v1.^2)); 

        %Check convergence measures
        v_iter_diff = sqrt(sum((v0-v1).^2));

        if iter > n_iter
            disp('Fail to converge! Increase the niter!')
            break
        end

        v0 = v1;
    end

    u = u0;
	v = v1;
end
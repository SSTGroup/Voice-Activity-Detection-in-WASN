% Implementation of the group sparse SVD for GSMM-NICA from [1]
%
%     Copyright (C) 2017 Martin Gölz
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
%[1] T. Hasija, M. Gölz, M. Muma, Peter J. Schreier and Abdelhak M. Zoubir,
%"Source Enumeration and Robust Voice Activity Detection in Wireless
%Acoustic Sensor Networks", Asilomar conference on signals, systems and
%computers, 2019.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [u, v, iter] = gssvd_UpdateV(Y,N_j)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %The rank-one group sparse singular value decomposition (SSVD)
 %  Requirement: thresh.m
 %
 % Input variables:
 %      - Y:            The MxN signal matrix to be decomposed
 %      - N_j :         Group sizes for the group LASSO (Number of elements
 %                      per block)
 %
 % Output variables: 
 %      - u:    The left sparse singular vector
 %      - v:    The right sparse singular vector
 %      - iter: The number of iterations required to achieve convergence
 %
 % Author: Martin Golz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [M, N]= size(Y);

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

    %Different lambda values
    cand_l_max = 0;
    for j = 1:N/N_j
        cand_l_max = max(cand_l_max, ...
            norm(u0.'*Y(:,(j-1)*N_j+1:j*N_j))/sqrt(N_j));
    end
    clear j;
    l_length = 100;
    l_range = 0:cand_l_max/(l_length-1):cand_l_max;
    
    v = zeros(N,l_length);
    
    %Least-Squares solution (required for computing df)
    v_ls = (pinv(u0.'*u0)*u0.'*Y).';
    
    %Total sum of squares of signal matrix elements 
    SST = sum(sum(Y.^2));
    
    %% Sparse update of v
    while (v_iter_diff > conv_thresh)
        iter = iter+1;      
        for j = 1:N/N_j
            for k = 1:l_length
                S_j = u0.'*Y(:,(j-1)*N_j+1:j*N_j);
                arg = (1-(l_range(k)*sqrt(N_j))/norm(S_j));
                if arg>0
                    v((j-1)*N_j+1:j*N_j, k) = (arg*S_j).';
                end
            end
        end
        clear j;
        clear k;
        
        %Ordinary least squares estimate of error variance in the sparse
        %optimization problem (Eq. 3.3) with (||Y'*u0||_2)^2 = SST_hat
        rho_squared = (SST - sum((Y'*u0).^2))/(M*N-N);
        
        %Initialization of C_N and degrees of freedom
        C_N = ones(l_length, 1)*Inf;
        df = zeros(l_length,1);
        for k = 1:l_length
            for j = 1:N/N_j
                df(k) = df(k) + double(norm(v((j-1)*N_j+1:j*N_j, k))>0);
                df(k) = df(k) + norm(v((j-1)*N_j+1:j*N_j, k))/...
                    norm(v_ls((j-1)*N_j+1:j*N_j))*(N_j-1);
            end
            C_N(k) = norm(Y-u0*v(:,k).')^2/var(Y,0,'all') - M + 2*df(k);
        end
        clear k;
        clear j;
        
        %Index at which C_N is maximized
        [~, min_ind] = min(C_N);
        v1 = v(:,min_ind);

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
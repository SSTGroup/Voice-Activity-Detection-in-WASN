%   File: Eval_Evec_Tests_Bootstrap_Multiple_Datasets.m
%   Copyright (c) <2019> <University of Paderborn>
%   Signal and System Theory Group, Univ. of Paderborn, http://sst.upb.de
%   https://github.com/SSTGroup/Voice-Activity-Detection-in-WASN
%
%   Permission is hereby granted, free of charge, to any person
%   obtaining a copy of this software and associated documentation
%   files (the "Software"), to deal in the Software without restriction,
%   including without limitation the rights to use, copy, modify and
%   merge the Software, subject to the following conditions:
%
%   1.) The Software is used for non-commercial research and
%       education purposes.
%
%   2.) The above copyright notice and this permission notice shall be
%       included in all copies or substantial portions of the Software.
%
%   3.) Publication, Distribution, Sublicensing, and/or Selling of
%       copies or parts of the Software requires special agreements
%       with the University of Paderborn and is in general not permitted.
%
%   4.) Modifications or contributions to the software must be
%       published under this license. The University of Paderborn
%       is granted the non-exclusive right to publish modifications
%       or contributions in future versions of the Software free of charge.
%
%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
%   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
%   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
%   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
%   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
%   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
%   OTHER DEALINGS IN THE SOFTWARE.
%
%   Persons using the Software are encouraged to notify the
%   Signal and System Theory Group at the University of Paderborn
%   about bugs. Please reference the Software in your publications
%   if it was used for them.
%
% ------------------------------------------------------------------------
% OVERVIEW:        This function implements Algorithm 1 of [1] and
% also incorporates modified Algorithm 2 for WASN
%
% ------------------------------------------------------------------------
% SYNTAX:
%
% [d_cap,Z] = Eval_Evec_Tests_Bootstrap_Multiple_Datasets(X_cell, P_fa_eval, P_fa_evec, B)
%
% INPUTS:
%
% 'X_cell'          Cell array of size P x 1.
%                   The pth cell contains a matrix of size n_p x M.  It is
%                   the matrix of observations of the pth data channel.
%
% 'P_fa_eval'       Probability of false alarm for hypothesis testing for eigenvalue
%                   test
% 'P_fa_evec_thres' Probability of false alarm for hypothesis testing for
%                   eigenvector test
% 'B'               Number of bootstrap iterations
%
% OUTPUTS:
%
% 'd_cap'           Estimated number of correlated components
%
% Z                 Cluster information matrix
%
%
% DEPENDENCIES:
%
% [1] hypothesis_testing_bt_eval_aug_coh_matrix.m
%
%       Included within.
%       Written by Tanuj Hasija.
%
%
% [2] hypothesis_testing_bt_evec_aug_coh_matrix_threshold.m
%
%       Included within.
%       Written by Tanuj Hasija.
%
% REFERENCES:
%
% This method:
% [1]   T. Hasija, C. Lameiro, T. Marrinan and P. J. Schreier,"Determining
%       the Dimension and Structure of the Subspace Correlated Across
%       Multiple Data Sets," Submitted.
%
% ------------------------------------------------------------------------
% CREATED:      14/01/2019 by Tanuj Hasija
%
% LAST EDITED:  31/10/2019 by Tanuj Hasija
%
% NOTES:
%
% ------------------------------------------------------------------------

function [d_cap,Z] = Eval_Evec_Tests_Bootstrap_Multiple_Datasets(X_cell, P_fa_eval, B, thres, P_fa_evec_thres)

P = size(X_cell,1); % Number of data sets
M = size(X_cell{1},2); % Numer of samples

tot_dim = 0;
X_aug = [];
Rxx_mH{P} = [];

for p=1:P
    X_aug = [X_aug;X_cell{p}];
    Rxx_mH{p} = sqrtm(inv(X_cell{p}*X_cell{p}'/M));
    m{p} = size(X_cell{p},1); % dimension of each data set
end

Rxx_aug = X_aug*X_aug'/M;

% Generating augmented coherence matrix
Rd_mH = Rxx_mH{1};
aug_dim{P} = []; aug_dim{1} = m{1}; % Augumented dimension required for eigenvector test

for p=2:P
    Rd_mH = blkdiag(Rd_mH,Rxx_mH{p});
    aug_dim{p} = aug_dim{p-1} + m{p};
end

Cxx_aug = Rd_mH*Rxx_aug*Rd_mH;
[U, E] = eig(Cxx_aug);
E = diag(E);
E = abs(E); % Sometimes for very few samples, E might be complex
[E,I] = sort(E,'descend');
U = U(:,I);
% U = abs(U);  % For checking

X_cell_star{P} = [];
% Bootstrap Operation
for b=1:B
    
    [~,I] = datasample(X_cell{1},M,2); % Bootstrap indices
    
    X_aug_star = [];
    Rxx_mH_star{P} = [];
    
    for p=1:P
        X_cell_star{p} = X_cell{p}(:,I);
        X_cell_star{p} = X_cell_star{p} - repmat(mean(X_cell_star{p},2),1,M);
        X_aug_star = [X_aug_star;X_cell_star{p}];
        Rxx_mH_star{p} = sqrtm(inv(X_cell_star{p}*X_cell_star{p}'/M));
    end
    
    % To use parfor and speed up this loop
    %     [X_aug_star,Rxx_mH_star] = return_aug_cov_matrix(X_cell,I,P,M);
    Rd_mH_star = Rxx_mH_star{1};
    
    for p=2:P
        Rd_mH_star = blkdiag(Rd_mH_star,Rxx_mH_star{p});
    end
    
    Rxx_aug_star = X_aug_star*X_aug_star'/M;
    Cxx_aug_star = Rd_mH_star*Rxx_aug_star*Rd_mH_star;
    [U_star, E_star] = eig(Cxx_aug_star);
    E_star = diag(E_star);
    E_star = abs(E_star);
    [E_star,I] = sort(E_star,'descend');
    U_star = U_star(:,I);
    %     U_star = abs(U_star); % For checking
    
    E_star_matrix(:,b) = E_star;
    U_star_matrix(:,:,b) = U_star;
    
end

d_cap = hypothesis_testing_bt_eval_aug_coh_matrix(P,P_fa_eval,E,E_star_matrix,B);
Z = hypothesis_testing_bt_evec_aug_coh_matrix_threshold(P,aug_dim, P_fa_evec_thres,d_cap,U,U_star_matrix,B,thres);

end

function d_cap = hypothesis_testing_bt_eval_aug_coh_matrix(P,P_fa_eval,E,E_star_matrix,B)
% Algorithm 1 of [1]
% Assuming that atleast P (no. of datasets) eigenvalues will be equal to 1

Lambda = E-1;
Lambda_star_matrix = E_star_matrix-1;
smax = 10; % To test for this application. The maximum possible d can be changed
for s=0:smax
    
    T = sum(Lambda(s+1:s+P).^2);
    
    for b=1:B
        T2_star(b) =  sum(Lambda_star_matrix(s+1:s+P,b).^2);
        T2_null(b) = T2_star(b) - T;
        if(abs(T) <= abs(T2_null(b)))
            Indicator(b) = 1;
        else
            Indicator(b) = 0;
        end
    end
    p_value = sum(Indicator)/B;
    if(p_value >= P_fa_eval)
        d_cap = s;
        break;
    end
    if(s == smax)
        d_cap=smax;
    end
end
end


function Z = hypothesis_testing_bt_evec_aug_coh_matrix_threshold(P,aug_dim, P_fa_evec,d_cap,U,U_star_matrix,B,thres)
% Returns the matrix for d_cap eigenvectors, i.e., whether the eigenvector
% components are 0 or 1 corresponding to d_cap components by comparing the
% eigenvector component to a threshold thres instead of 0.

Z = zeros(d_cap,P);

for i=1:d_cap
    
    for p=1:P
        present = 1;
        if p==1
            dim1 = 1;
        else
            dim1 = aug_dim{p-1}+1;
        end
        
        dim2 = aug_dim{p};
        T0 = norm(U(dim1:dim2,i));
        T = T0 - thres;
        
        for b=1:B
            T2_star(b) = norm(U_star_matrix(dim1:dim2,i,b));
            T2_null(b) = T2_star(b) - T0;
            if((T) <= (T2_null(b)))
                Indicator(b) = 1;
            else
                Indicator(b) = 0;
            end
        end
        p_value = sum(Indicator)/B;
        if(p_value >= P_fa_evec)
            present = 0;
        end
        Z(i,p) = present;
        
    end
end

end

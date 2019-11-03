% Implementation of voice activity detection by SMM-NICA from [1]
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
function [S]=batchmodeMNICA_ssvd(Y,Q,nbiter,gamv_scal)
    
    %The sparse singular value decomposition
    [Y,U,V,SIGMA]=Reconstruction_ssvd_easy(Y,Q,gamv_scal);
    
    V1=V;
    
    S=abs(V1)';

    for j=1:nbiter

        z=find(sum(S,2)==0); %avoid zero-rows in Stemp
        if ~isempty(z)
            S(z,:)=ones(length(z),size(S,2)); %add dummy-row in case a row is zero
        end

        %%%COMPUTATION OF THE DECORRELATION STEP
        
        Smean=median(S,2)*ones(1,size(S,2));
        
        L=diag(diag((S-Smean)*(S'-Smean')))+1e-9*eye(Q);
        L2=diag(diag((S-Smean)*(S'-Smean')*L^(-1)*(S-Smean)*(S'-Smean')));
        C=Smean*S';
        B=S*S';
         numerator=L*C*L^(-1)*S+L*B*L^(-1)*Smean+L2*S;
         denominator=L*C*L^(-1)*Smean+L*B*L^(-1)*S+L2*Smean;

        S = S.*numerator./(denominator+1e-9);
        

    end
    K=S*abs(V1);%*SIGMA^(-1)*U';% it does not matter if we really need the absolute value since nonnegativity should be only on S
    %K=S*Q*SIGMA^(-1)*U';
    A=abs(V1)'*pinv(S); %Y replaced by Q

    %A=Y*pinv(S);

    %normalize columns of A
    norms = diag(sqrt(sum(A.^2)));
    A=A*pinv(norms);
    K=norms*K;
    S=norms*S;
end
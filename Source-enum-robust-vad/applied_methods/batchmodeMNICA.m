% Implementation of batch-mode M-NICA, as proposed in [1] and [2]

%     Copyright (C) 2010  Alexander Bertrand
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
% alexander.bertrand@esat.kuleuven.be
% http://homes.esat.kuleuven.be/~abertran

%%%  REFERENCES %%%
%[1] A. Bertrand and M. Moonen, "Blind separation of non-negative source signals using multiplicative updates and subspace projection", Signal Processing, vol. 90, no.10, pp. 2877-2890, 2010.

%[2] A. Bertrand and M. Moonen, "Energy-based multi-speaker voice activity detection with an ad hoc microphone array", Proc. of the IEEE International Conference on Acoustics, Speech and Signal processing (ICASSP), Dallas, Texas USA, 2010, pp. 85-88.

%%%  NOTE  %%%%
%%% !!!In paper [2] (in the version as published by IEEE), there is an error in formula (6): The nominator and denominator must be switched.
%%% This error is corrected in the version that is downloadable on
%%% ftp://ftp.esat.kuleuven.be/pub/SISTA/abertran/papers_website/09-186.html
%%% The paper [1] contains the correct formula.



%%%%%%%%%%%%  batch-mode M-NICA %%%%%%%%%%%%%

%%%  INPUTS  %%%%%
%% Y= M x N matrix containing M signals, each containing N samples
%% rdim= number of underlying source signals to be unmixed
%% nbiter= number of iterations

%%%  OUTPUTS  %%%%%
%% A=estimated M x rdim mixing matrix
%% S= rdim x N matrix with estimated source signals
%% K= rdim x M demixing matrix

%%EXAMPLE for 3 sources and 20 iterations:
% [A,S,K]=batchmodeMNICA(Y,3,20);

function [A,S,K]=batchmodeMNICA(Y,rdim,nbiter)

display('Copyright (C) 2010  Alexander Bertrand')
S=abs(Y(1:rdim,:)); %will contain source estimates (initialization)
[u,sigma,q]=svd(Y,'econ');
Q=q(:,1:rdim);
SIGMA=sigma(1:rdim,1:rdim);
U=u(:,1:rdim);
Y=U*SIGMA*Q'; %Truncated SVD (best rank rdim-approximation)

for j=1:nbiter
    
    z=find(sum(S,2)==0); %avoid zero-rows in Stemp
    if ~isempty(z)
        S(z,:)=ones(length(z),size(S,2)); %add dummy-row in case a row is zero
    end
    
    %%%COMPUTATION OF THE DECORRELATION STEP
    Smean=mean(S,2)*ones(1,size(S,2));
    %Smean=median(S,2)*ones(1,size(S,2));
    %Smean=1.253*mad(S,1,2)*ones(1,size(S,2));
    %Smean=1.4826*mad(S,1,2)*ones(1,size(S,2));
    L=diag(diag((S-Smean)*(S'-Smean')))+1e-9*eye(rdim);
    L2=diag(diag((S-Smean)*(S'-Smean')*L^(-1)*(S-Smean)*(S'-Smean')));
    C=Smean*S';
    B=S*S';
    numerator=L*C*L^(-1)*S+L*B*L^(-1)*Smean+L2*S;
    denominator=L*C*L^(-1)*Smean+L*B*L^(-1)*S+L2*Smean;
    S = S.*numerator./(denominator+1e-9);
    
    %%% Note: in the paper "Energy-based multi-speaker voice activity
    %%% detection with an ad hoc microphone array", as published by IEEE,
    %%% there is an error in formula (6). The nominator and denominator must be switched.
    %%% This error is corrected in the version that is downloadable on
    %%% ftp://ftp.esat.kuleuven.be/pub/SISTA/abertran/papers_website/09-186.html
    
    S=max((S*Q)*Q',0); %subspace projection step
    
end
K=S*Q*SIGMA^(-1)*U';% Unmixing
A=Y*pinv(S);% Mixing

%normalize columns of A
norms = diag(sqrt(sum(A.^2)));
A=A*pinv(norms);
K=norms*K;
S=norms*S;
end

    
    
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Y,U,V,Sigma]=Reconstruction_ssvd_easy(Y,Q,gamv_scal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Input variables:
 %      - Y:            The MxN signal matrix to be decomposed
 %      - Q:            The number of sources hidden in the signal matrix
 %      - gamv_scal:    weight parameter in Adaptive LASSO for the  
 %                      right singular vector, nonnegative constant 
 %                      (default = 0, LASSO)
 % Output variables: 
 %      - Y: The signal matrix as approximated by its decomposition USV'
 %      - U: The MxM left rotational matrix
 %      - V: The NxN sparse right rotational matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Initialization of the resulting decomposed components 
    U=[];
    V=[];
    Sigma=zeros(Q,Q);
    
    %For each signal component q = 1,..., Q, a rank-one decomposition is to
    %be performed
    
    for q=1:Q
        [u_q, v_q, ~] = ssvd_UpdateV(Y,gamv_scal);

        %Concatenate the results for the current signal component with the
        %previous components
        U=[U u_q];
        V=[V v_q];
        Sigma(q,q)=u_q'*Y*v_q;
        Y=Y-Sigma(q,q)*u_q*v_q';
    end

    Y=U*Sigma*V';
end
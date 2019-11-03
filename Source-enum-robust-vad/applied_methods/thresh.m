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
function gam_tilde = thresh(y,para)
    
    % 
    % Input : 
    %   y    -  argument (a number or a vector )
    %
    
    
% default values
type = 1;
lambda = min(y)/2;
a = 3.7; 

if nargin > 1 % then para has been added
    if isfield(para,'type')
        type = getfield(para, 'type');
    end
    
    if isfield(para, 'lambda')
        lambda = getfield(para, 'lambda');
    end
    
    if isfield(para, 'a')
        a = getfield(para, 'a');
    end
    
else
    para = struct('nothing',[]);
end

if type==1
    gam_tilde = sign(y).*(abs(y)>=lambda).*(abs(y)-lambda);
elseif type==2
    gam_tilde = y.*(abs(y)>lambda);
else
    gam_tilde = sign(y).*(abs(y)>=lambda).*(abs(y)-lambda).*(abs(y)<=2*lambda)...
        +((a-1).*y-sign(y)*a*lambda)/(a-2).*(2*lambda<abs(y)).*(abs(y)<=a*lambda)...
        +y.*(abs(y)>a*lambda);
end

 
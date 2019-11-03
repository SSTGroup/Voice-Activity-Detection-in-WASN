%   File: clustering.m
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
% OVERVIEW:        This function implements source enumeration and
% clustering in [1]
%
% ------------------------------------------------------------------------
%
% DEPENDENCIES:
%
% [1] Eval_Evec_Tests_Bootstrap_Multiple_Datasets
%
%       Included within.
%       Written by Tanuj Hasija.
%
%
%
% REFERENCES:
%
%
% [1]   T. Hasija,M. Gölz, M. Muma, P. J. Schreier and A. M. Zoubir,
% "Source Enumeration and Robust Voice ActivityDetection in Wireless
% Acoustic Sensor Networks," Proc. Asilomar Conf. Signals Syst. Computers,
% Pacific Grove, CA, USA, November 2019.
%
% ------------------------------------------------------------------------
% CREATED:      01/03/2019 by Tanuj Hasija
%
% LAST EDITED:  31/10/2019 by Tanuj Hasija
%
% NOTES:
%
% ------------------------------------------------------------------------

% To create own scenario
% join_micsigs_sc1; % This file can be used to generate custom scenarios
% apart from scenarios 1 and 2. Currently it codes scenarios 1 and 2 and
% saves to mat files.

clear Y_cell; clear Y; clear Y_f_cell; clear Y_f_zm; clear Y_f;

switch lower(scenario)
    case 'scen_1'
        addpath('data-scenario1/');
        load('micsignals_scen_1.mat');
    case 'scen_2'
        addpath('data-scenario2/');
        load('micsignals_scen_2.mat');
    otherwise
        error('Unknown scenario');
end

P = size(mics,3); % P=number of sensors
n=3; %n=dimension of each sensor
M = size(mics,1); %M=number of time points
Y = reshape(mics,[M,3*P,1]);
Y = Y.'; % Data matrix Y is of size nP*M

% Making the data zero-mean
mY = mean(Y,2);
Y = Y - repmat(mY,1,M);

% STFT parameters
no_f_bins = 32; % Number of frequency bins
frame_size=1024; % Window size for STFT

% Computing the stft
for i=1:size(Y,1)
    Sy = spectrogram(Y(i,:),frame_size,[],2*(no_f_bins-1),fs_target);
    Sy=Sy';
    Y_f(i,:,:) = Sy;
end

% Zero mean the STFT data
for b=1:no_f_bins
    mY = mean(Y_f(:,:,b),2);
    Y_f_zm(:,:,b) = Y_f(:,:,b) - repmat(mY,1,size(Y_f,2));
end

Y_f_cell = cell(P,1);
for p=1:P
    id1=(p-1)*n+1; id2=n*p;
    Y_f_cell{p} = Y_f_zm(id1:id2,:,:);
end

d_max=10; % Maximum value chosen for d
Clusters_bin = zeros(d_max,P,no_f_bins);

% Do evaluation for each bin
for b=1:no_f_bins
    Y_cell = cell(P,1);
    for p=1:P
        id1=(p-1)*n+1; id2=n*p;
        Y_cell{p} = Y_f_zm(id1:id2,:,b);
    end
    % Detector parameters
    thres = 1/sqrt(P);
    switch lower(scenario)
        case 'scen_1'
            Pfa_eval=0.01;
            B=1000;
            Pfa_evec_thres=0.01;
        case 'scen_2'
            Pfa_eval=0.001;
            B=2000;
            Pfa_evec_thres=0.005;
    end
    [d_hat_bt,Z_bin] = Eval_Evec_Tests_Bootstrap_Multiple_Datasets(Y_cell,Pfa_eval,B,thres,Pfa_evec_thres);
    d_vec_bt(b) = d_hat_bt;
    Clusters_bin(1:d_hat_bt,:,b) = Z_bin;
end

d_hat = round(mean(d_vec_bt)); % Estimated number of dominant sources
% Compute majority-voted d_hat clusters
Cluster_vec = zeros(1,2^P + 1);
for b=1:no_f_bins
    for i=1:d_hat
        clus_num2 =  bin2dec(num2str(Clusters_bin(i,:,b)));
        Cluster_vec(clus_num2+1) =  Cluster_vec(clus_num2+1)+1;
    end
end
[Cluster_vec_sorted2,idx2] = sort(Cluster_vec,'descend');

s=1; i=1;
while (s<=d_hat)
    if(idx2(i)~=1)
        Z_hat(s,:)= dec2bin(idx2(i)-1,P);
        s=s+1;
    end
    i=i+1;
end
display('Cluster information matrix');
display(Z_hat)
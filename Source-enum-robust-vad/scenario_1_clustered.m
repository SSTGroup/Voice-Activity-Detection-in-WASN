%% Source decorrelation after clustering according to dominant source model
%Decorrelation by SMM-NICA and GSMM-NICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load microphone recordings
addpath('data-scenario1/');
load 'micsignals_SC1_A_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,6)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC1_A_clust = zeros(6, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC1_A_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
addpath('applied_methods/');
SMMNICA_SC1_A_clust = batchmodeMNICA_ssvd(Y_SC1_A_clust, 1, 40, 0);
t_clusteredSM(1) = toc;
%% Decorrelation by GSMM-NICA
tic
GSMMNICA_SC1_A_clust = batchmodeMNICA_gssvd(Y_SC1_A_clust, 1, 40, block_length);
t_clusteredGSM(1) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load microphone recordings
load 'micsignals_SC1_B_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,9)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC1_B_clust = zeros(9, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC1_B_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
SMMNICA_SC1_B_clust= batchmodeMNICA_ssvd(Y_SC1_B_clust, 1, 40, 0);
t_clusteredSM(2) = toc;
%% Decorrelation by GSMM-NICA
tic
GSMMNICA_SC1_B_clust= batchmodeMNICA_gssvd(Y_SC1_B_clust, 1, 40, block_length);
t_clusteredGSM(2) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load microphone recordings
load 'micsignals_SC1_C_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,6)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC1_C_clust = zeros(6, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC1_C_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
SMMNICA_SC1_C_clust= batchmodeMNICA_ssvd(Y_SC1_C_clust, 1, 40, 0);
t_clusteredSM(3) = toc;
%% Decorrelation by GSMM-NICA
tic
GSMMNICA_SC1_C_clust= batchmodeMNICA_gssvd(Y_SC1_C_clust, 1, 40, block_length);
t_clusteredGSM(3) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting
figure('Name','Sc. 1: Clustered SMM-NICA with white noise','NumberTitle','off');
subplot(3,1,1)
plot(SMMNICA_SC1_A_clust)
title('A')
subplot(3,1,2)
plot(SMMNICA_SC1_B_clust)
title('B')
subplot(3,1,3)
plot(SMMNICA_SC1_C_clust)
title('C')

figure('Name','Sc. 1: Clustered GSMM-NICA with white noise','NumberTitle','off');
subplot(3,1,1)
plot(GSMMNICA_SC1_A_clust)
title('A')
subplot(3,1,2)
plot(GSMMNICA_SC1_B_clust)
title('B')
subplot(3,1,3)
plot(GSMMNICA_SC1_C_clust)
title('C')
%% Source decorrelation after clustering according to dominant source model
%Decorrelation by SMM-NICA and GSMM-NICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load microphone recordings
addpath('data-scenario2/');
load 'micsignals_SC2_D_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,9)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC2_D_clust = zeros(9, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC2_D_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
addpath('applied_methods/');
SMMNICA_SC2_D_clust = batchmodeMNICA_ssvd(Y_SC2_D_clust, 1, 40, 0);
t_clusteredSM(4) = toc;
%% Decorrelation by GSMM-NICA
tic
GSMMNICA_SC2_D_clust = batchmodeMNICA_gssvd(Y_SC2_D_clust, 1, 40, block_length);
t_clusteredGSM(4) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load microphone recordings
load 'micsignals_SC2_A_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,9)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC2_A_clust = zeros(9, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC2_A_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
SMMNICA_SC2_A_clust = batchmodeMNICA_ssvd(Y_SC2_A_clust, 1, 40,0);
t_clusteredSM(5) = toc;
%% Decorrelation by GSMM-NICA
tic
GSMMNICA_SC2_A_clust = batchmodeMNICA_gssvd(Y_SC2_A_clust, 1, 40, block_length);
t_clusteredGSM(5) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load microphone recordings
load 'micsignals_SC2_B_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,9)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC2_B_clust = zeros(9, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC2_B_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
SMMNICA_SC2_B_clust= batchmodeMNICA_ssvd(Y_SC2_B_clust, 1, 40, 0);
t_clusteredSM(6) = toc;
%% Decorrelation by SMM-NICA
tic
GSMMNICA_SC2_B_clust= batchmodeMNICA_gssvd(Y_SC2_B_clust, 1, 40, block_length);
t_clusteredGSM(6) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load microphone recordings
load 'micsignals_SC2_C_clust.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,9)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC2_C_clust = zeros(9, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC2_C_clust(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by SMM-NICA
tic
SMMNICA_SC2_C_clust= batchmodeMNICA_ssvd(Y_SC2_C_clust, 1, 40, 0);
t_clusteredSM(7) = toc;
%% Decorrelation by GSMM-NICA
tic
GSMMNICA_SC2_C_clust= batchmodeMNICA_gssvd(Y_SC2_C_clust, 1, 40, block_length);
t_clusteredGSM(7) = toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting
figure('Name','Sc. 2: Clustered SMM-NICA with white noise','NumberTitle','off');
subplot(4,1,4)
plot(SMMNICA_SC2_D_clust)
title('D')
subplot(4,1,1)
plot(SMMNICA_SC2_A_clust)
title('A')
subplot(4,1,2)
plot(SMMNICA_SC2_B_clust)
title('B')
subplot(4,1,3)
plot(SMMNICA_SC2_C_clust)
title('C')

figure('Name','Sc. 2: Clustered GSMM-NICA with white noise','NumberTitle','off');
subplot(4,1,4)
plot(GSMMNICA_SC2_D_clust)
title('D')
subplot(4,1,1)
plot(GSMMNICA_SC2_A_clust)
title('A')
subplot(4,1,2)
plot(GSMMNICA_SC2_B_clust)
title('B')
subplot(4,1,3)
plot(GSMMNICA_SC2_C_clust)
title('C')
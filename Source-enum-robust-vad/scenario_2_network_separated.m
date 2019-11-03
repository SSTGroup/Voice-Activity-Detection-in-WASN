%% Clean and standalone speach signals decorrelated by MNICA network-wide
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
    addpath('data-scenario2/');
    load 'micsignals_SC2_D_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC2_D(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    
    load 'micsignals_SC2_C_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC2_C(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    
    clear mics;
    
    load 'micsignals_SC2_A_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC2_A(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    
    clear mics;
    
    load 'micsignals_SC2_B_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC2_B(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    
    clear mics;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by MNICA
addpath('applied_methods/');
[~, MNICA_SC2_A, ~] = batchmodeMNICA(Y_SC2_A, 1, 40);
[~, MNICA_SC2_B, ~] = batchmodeMNICA(Y_SC2_B, 1, 40);
[~, MNICA_SC2_C, ~] = batchmodeMNICA(Y_SC2_C, 1, 40);
[~, MNICA_SC2_D, ~] = batchmodeMNICA(Y_SC2_D, 1, 40);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the undistorted signals
figure('Name','Sc. 2: Clean Individual Signals','NumberTitle','off');
subplot(4,1,4)
plot(MNICA_SC2_D)
title('D')
subplot(4,1,1)
plot(MNICA_SC2_A)
title('A')
subplot(4,1,2)
plot(MNICA_SC2_B)
title('B')
subplot(4,1,3)
plot(MNICA_SC2_C)
title('C')
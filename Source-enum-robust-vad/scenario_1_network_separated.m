%% Clean and standalone speach signals decorrelated by MNICA network-wide
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
    addpath('data-scenario1/');
    load 'micsignals_SC1_A_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC1_A(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    
    clear mics;
    
    load 'micsignals_SC1_B_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC1_B(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    clear mics;
    
    load 'micsignals_SC1_C_network_clean.mat';
    Y_tilde = reshape(mics, 1440000,num_active_mics)';
    blocks = [1:1440000/stat_int];
    block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
    for i = 1:length(blocks)
        Y_SC1_C(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
    end
    clear mics;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by MNICA
addpath('applied_methods/');
[~, MNICA_SC1_A, ~] = batchmodeMNICA(Y_SC1_A, 1, 40);
[~, MNICA_SC1_B, ~] = batchmodeMNICA(Y_SC1_B, 1, 40);
[~, MNICA_SC1_C, ~] = batchmodeMNICA(Y_SC1_C, 1, 40);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting the undistorted signals
figure('Name','Sc. 1: Clean individual Signals','NumberTitle','off');
subplot(3,1,1)
plot(MNICA_SC1_A)
title('A')
subplot(3,1,2)
plot(MNICA_SC1_B)
title('B')
subplot(3,1,3)
plot(MNICA_SC1_C)
title('C')

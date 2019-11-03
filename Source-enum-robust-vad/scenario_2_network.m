%% Source decorrelation based on network-wide observations by M-NICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate or load microphone recording scenarios
%join_micsigs;
addpath('data-scenario2/');
load 'micsignals_SC2_network_clean.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,num_active_mics)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC2_clean = zeros(num_active_mics, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC2_clean(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by MNICA
[~, MNICA_SC2_network_clean, ~] = batchmodeMNICA(Y_SC2_clean, num_sourc, 40);
% figure('Name','Sc. 2: Network-wide M-NICA without white noise','NumberTitle','off');
% subplot(num_sourc,1,2)
% plot(MNICA_SC2_network_clean(1,:))
% title('B')
% subplot(num_sourc,1,3)
% plot(MNICA_SC2_network_clean(3,:))
% title('C')
% subplot(num_sourc,1,4)
% plot(MNICA_SC2_network_clean(2,:))
% title('D')
% subplot(num_sourc,1,1)
% plot(MNICA_SC2_network_clean(4,:))
% title('A')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate or load microphone recording scenarios
%join_micsigs;
load 'micsignals_SC2_network.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,num_active_mics)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC2 = zeros(num_active_mics, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC2(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by MNICA
tic
addpath('applied_methods/');
[~, MNICA_SC2_network, ~] = batchmodeMNICA(Y_SC2, num_sourc, 40);
t_network(2) = toc;
figure('Name','Sc. 2: Network-wide M-NICA with white noise','NumberTitle','off');
subplot(num_sourc,1,2)
plot(MNICA_SC2_network(4,:))
title('B')
subplot(num_sourc,1,3)
plot(MNICA_SC2_network(3,:))
title('C')
subplot(num_sourc,1,4)
plot(MNICA_SC2_network(1,:))
title('D')
subplot(num_sourc,1,1)
plot(MNICA_SC2_network(2,:))
title('A')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
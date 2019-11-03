%% Source decorrelation based on network-wide observations by M-NICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate or load microphone recording scenarios
%join_micsigs;
addpath('data-scenario1/');
load 'micsignals_SC1_network.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute energy signatures
Y_tilde = reshape(mics, 1440000,num_active_mics)';
blocks = 1:(1440000/stat_int);
block_inds = repmat(((blocks-1).*stat_int)',1,stat_int)+repmat(1:stat_int,length(blocks),1);
Y_SC1 = zeros(num_active_mics, 1440000/stat_int);
for i = 1:length(blocks)
    Y_SC1(:,i) = 1/stat_int*sum(Y_tilde(:,block_inds(i,:)).^2,2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decorrelation by MNICA
tic
addpath('applied_methods/');
[~, MNICA_SC1_network, ~] = batchmodeMNICA(Y_SC1, num_sourc, 40);
t_network(1) = toc;
figure('Name','Sc. 1: Network-wide M-NICA with white noise','NumberTitle','off');
subplot(num_sourc,1,1)
plot(MNICA_SC1_network(1,:))
title('A')
subplot(num_sourc,1,2)
plot(MNICA_SC1_network(3,:))
title('B')
subplot(num_sourc,1,3)
plot(MNICA_SC1_network(2,:))
title('C')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
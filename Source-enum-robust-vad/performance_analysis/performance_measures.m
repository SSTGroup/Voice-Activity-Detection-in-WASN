%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%After main.m has been executed, this function can be used to compute a
%variety of performance measures.
%Input variables:
%   - sc1_length, sc2_length:   Signal frame lengths for both scenarios 
%                               (max 3000 frames)
%Ouput variables:
%   - rho:   Correlation coefficient between source energy signature and
%            estimated energy signature
%   - NRSME: Normalized Root Mean Squared Error between true and estimated
%            energy signatures as defined in the report
%   - SCx_y_VAP: The true voice activity pattern (manually defined for each
%                source, the estimated VAPs by the tested algorithms are
%                defined along. 
%   - pcd:   Probability of correct decision
%   - pmd:   Probability of missed detection
%   - pfa:   Probability of false alarm
%   - fdp:   False discovery proportion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc1_length = 500;
sc2_length = 1000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Correlation coefficient
rho_SC1_A_network = corr(MNICA_SC1_network(1,1:sc1_length)', MNICA_SC1_A(1:sc1_length)');
rho_SC1_A_clusteredSM = corr(SMMNICA_SC1_A_clust(1:sc1_length)', MNICA_SC1_A(1:sc1_length)');
rho_SC1_A_clusteredGSM = corr(GSMMNICA_SC1_A_clust(1:sc1_length)', MNICA_SC1_A(1:sc1_length)');
rho_SC1_B_network = corr(MNICA_SC1_network(3,1:sc1_length)', MNICA_SC1_B(1:sc1_length)');
rho_SC1_B_clusteredSM = corr(SMMNICA_SC1_B_clust(1:sc1_length)', MNICA_SC1_B(1:sc1_length)');
rho_SC1_B_clusteredGSM = corr(GSMMNICA_SC1_B_clust(1:sc1_length)', MNICA_SC1_B(1:sc1_length)');
rho_SC1_C_network = corr(MNICA_SC1_network(2,1:sc1_length)', MNICA_SC1_C(1:sc1_length)');
rho_SC1_C_clusteredSM = corr(SMMNICA_SC1_C_clust(1:sc1_length)', MNICA_SC1_C(1:sc1_length)');
rho_SC1_C_clusteredGSM = corr(GSMMNICA_SC1_C_clust(1:sc1_length)', MNICA_SC1_C(1:sc1_length)');

rho_SC2_A_network = corr(MNICA_SC2_network(2,1:sc2_length)', MNICA_SC2_A(1:sc2_length)');
rho_SC2_A_clusteredSM = corr(SMMNICA_SC2_A_clust(1:sc2_length)', MNICA_SC2_A(1:sc2_length)');
rho_SC2_A_clusteredGSM = corr(GSMMNICA_SC2_A_clust(1:sc2_length)', MNICA_SC2_A(1:sc2_length)');
rho_SC2_B_network = corr(MNICA_SC2_network(4,1:sc2_length)', MNICA_SC2_B(1:sc2_length)');
rho_SC2_B_clusteredSM = corr(SMMNICA_SC2_B_clust(1:sc2_length)', MNICA_SC2_B(1:sc2_length)');
rho_SC2_B_clusteredGSM = corr(GSMMNICA_SC2_B_clust(1:sc2_length)', MNICA_SC2_B(1:sc2_length)');
rho_SC2_C_network = corr(MNICA_SC2_network(3,1:sc2_length)', MNICA_SC2_C(1:sc2_length)');
rho_SC2_C_clusteredSM = corr(SMMNICA_SC2_C_clust(1:sc2_length)', MNICA_SC2_C(1:sc2_length)');
rho_SC2_C_clusteredGSM = corr(GSMMNICA_SC2_C_clust(1:sc2_length)', MNICA_SC2_C(1:sc2_length)');
rho_SC2_D_network = corr(MNICA_SC2_network(1,1:sc2_length)', MNICA_SC2_D(1:sc2_length)');
rho_SC2_D_clusteredSM = corr(SMMNICA_SC2_D_clust(1:sc2_length)', MNICA_SC2_D(1:sc2_length)');
rho_SC2_D_clusteredGSM = corr(GSMMNICA_SC2_D_clust(1:sc2_length)', MNICA_SC2_D(1:sc2_length)');

rhos = [rho_SC1_A_network, rho_SC1_A_clusteredSM, rho_SC1_A_clusteredGSM;...
    rho_SC1_B_network, rho_SC1_B_clusteredSM, rho_SC1_B_clusteredGSM;...
    rho_SC1_C_network, rho_SC1_C_clusteredSM, rho_SC1_C_clusteredGSM;
    rho_SC2_A_network, rho_SC1_A_clusteredSM, rho_SC1_A_clusteredGSM;...
    rho_SC2_B_network, rho_SC2_B_clusteredSM, rho_SC2_B_clusteredGSM;...
    rho_SC2_C_network, rho_SC2_C_clusteredSM, rho_SC2_C_clusteredGSM;...
    rho_SC2_D_network, rho_SC2_D_clusteredSM, rho_SC2_D_clusteredGSM];



%% NRMSE
NRMSE_SC1_A_network = sqrt(1/sc1_length*sum((MNICA_SC1_A(1:sc1_length)/max(MNICA_SC1_A(1:sc1_length))-...
    MNICA_SC1_network(1,1:sc1_length)/max(MNICA_SC1_network(1,1:sc1_length))).^2));
NRMSE_SC1_A_clusteredSM = sqrt(1/sc1_length*sum(((MNICA_SC1_A(1:sc1_length))/max(MNICA_SC1_A(1:sc1_length))-...
    (SMMNICA_SC1_A_clust(1:sc1_length))/max(SMMNICA_SC1_A_clust(1:sc1_length))).^2));
NRMSE_SC1_A_clusteredGSM = sqrt(1/sc1_length*sum(((MNICA_SC1_A(1:sc1_length))/max(MNICA_SC1_A(1:sc1_length))-...
    (GSMMNICA_SC1_A_clust(1:sc1_length))/max(GSMMNICA_SC1_A_clust(1:sc1_length))).^2));
NRMSE_SC1_B_network = sqrt(1/sc1_length*sum(((MNICA_SC1_B(1:sc1_length))/max(MNICA_SC1_B(1:sc1_length))-...
    (MNICA_SC1_network(3,(1:sc1_length)))/max(MNICA_SC1_network(3,(1:sc1_length)))).^2));
NRMSE_SC1_B_clusteredSM = sqrt(1/sc1_length*sum(((MNICA_SC1_B(1:sc1_length))/max(MNICA_SC1_B(1:sc1_length))-...
    (SMMNICA_SC1_B_clust(1:sc1_length))/max(SMMNICA_SC1_B_clust(1:sc1_length))).^2));
NRMSE_SC1_B_clusteredGSM = sqrt(1/sc1_length*sum(((MNICA_SC1_B(1:sc1_length))/max(MNICA_SC1_B(1:sc1_length))-...
    (GSMMNICA_SC1_B_clust(1:sc1_length))/max(GSMMNICA_SC1_B_clust(1:sc1_length))).^2));
NRMSE_SC1_C_network = sqrt(1/sc1_length*sum(((MNICA_SC1_C(1:sc1_length))/max(MNICA_SC1_C(1:sc1_length))-...
    (MNICA_SC1_network(2,(1:sc1_length)))/max(MNICA_SC1_network(2,(1:sc1_length)))).^2));
NRMSE_SC1_C_clusteredSM = sqrt(1/sc1_length*sum(((MNICA_SC1_C(1:sc1_length))/max(MNICA_SC1_C(1:sc1_length))-...
    (SMMNICA_SC1_C_clust(1:sc1_length))/max(SMMNICA_SC1_C_clust(1:sc1_length))).^2));
NRMSE_SC1_C_clusteredGSM = sqrt(1/sc1_length*sum(((MNICA_SC1_C(1:sc1_length))/max(MNICA_SC1_C(1:sc1_length))-...
    (GSMMNICA_SC1_C_clust(1:sc1_length))/max(GSMMNICA_SC1_C_clust(1:sc1_length))).^2));

NRMSE_SC2_D_network = sqrt(1/sc2_length*sum(((MNICA_SC2_D(1:sc2_length))/max(MNICA_SC2_D(1:sc2_length))-...
    (MNICA_SC2_network(1,(1:sc2_length)))/max(MNICA_SC2_network(1,(1:sc2_length)))).^2));
NRMSE_SC2_D_clusteredSM = sqrt(1/sc2_length*sum(((MNICA_SC2_D(1:sc2_length))/max(MNICA_SC2_D(1:sc2_length))-...
    (SMMNICA_SC2_D_clust(1:sc2_length))/max(SMMNICA_SC2_D_clust(1:sc2_length))).^2));
NRMSE_SC2_D_clusteredGSM = sqrt(1/sc2_length*sum(((MNICA_SC2_D(1:sc2_length))/max(MNICA_SC2_D(1:sc2_length))-...
    (GSMMNICA_SC2_D_clust(1:sc2_length))/max(GSMMNICA_SC2_D_clust(1:sc2_length))).^2));
NRMSE_SC2_B_network = sqrt(1/sc2_length*sum(((MNICA_SC2_B(1:sc2_length))/max(MNICA_SC2_B(1:sc2_length))-...
    (MNICA_SC2_network(4,(1:sc2_length)))/max(MNICA_SC2_network(4,(1:sc2_length)))).^2));
NRMSE_SC2_B_clusteredSM = sqrt(1/sc2_length*sum(((MNICA_SC2_B(1:sc2_length))/max(MNICA_SC2_B(1:sc2_length))-...
    (SMMNICA_SC2_B_clust(1:sc2_length))/max(SMMNICA_SC2_B_clust(1:sc2_length))).^2));
NRMSE_SC2_B_clusteredGSM = sqrt(1/sc2_length*sum(((MNICA_SC2_B(1:sc2_length))/max(MNICA_SC2_B(1:sc2_length))-...
    (GSMMNICA_SC2_B_clust(1:sc2_length))/max(GSMMNICA_SC2_B_clust(1:sc2_length))).^2));
NRMSE_SC2_A_network = sqrt(1/sc2_length*sum(((MNICA_SC2_A(1:sc2_length))/max(MNICA_SC2_A(1:sc2_length))-...
    (MNICA_SC2_network(2,(1:sc2_length)))/max(MNICA_SC2_network(2,(1:sc2_length)))).^2));
NRMSE_SC2_A_clusteredSM = sqrt(1/sc2_length*sum(((MNICA_SC2_A(1:sc2_length))/max(MNICA_SC2_A(1:sc2_length))-...
    (SMMNICA_SC2_A_clust(1:sc2_length))/max(SMMNICA_SC2_A_clust(1:sc2_length))).^2));
NRMSE_SC2_A_clusteredGSM = sqrt(1/sc2_length*sum(((MNICA_SC2_A(1:sc2_length))/max(MNICA_SC2_A(1:sc2_length))-...
    (GSMMNICA_SC2_A_clust(1:sc2_length))/max(GSMMNICA_SC2_A_clust(1:sc2_length))).^2));
NRMSE_SC2_C_network = sqrt(1/sc2_length*sum(((MNICA_SC2_C(1:sc2_length))/max(MNICA_SC2_C(1:sc2_length))-...
    (MNICA_SC2_network(3,(1:sc2_length)))/max(MNICA_SC2_network(3,(1:sc2_length)))).^2));
NRMSE_SC2_C_clusteredSM = sqrt(1/sc2_length*sum(((MNICA_SC2_C(1:sc2_length))/max(MNICA_SC2_C(1:sc2_length))-...
    (SMMNICA_SC2_C_clust(1:sc2_length))/max(SMMNICA_SC2_C_clust(1:sc2_length))).^2));
NRMSE_SC2_C_clusteredGSM = sqrt(1/sc2_length*sum(((MNICA_SC2_C(1:sc2_length))/max(MNICA_SC2_C(1:sc2_length))-...
    (GSMMNICA_SC2_C_clust(1:sc2_length))/max(GSMMNICA_SC2_C_clust(1:sc2_length))).^2));

NRMSEs = [NRMSE_SC1_A_network, NRMSE_SC1_A_clusteredSM, NRMSE_SC1_A_clusteredGSM;...
    NRMSE_SC1_B_network, NRMSE_SC1_B_clusteredSM, NRMSE_SC1_B_clusteredGSM;...
    NRMSE_SC1_C_network, NRMSE_SC1_C_clusteredSM, NRMSE_SC1_C_clusteredGSM;...
    NRMSE_SC2_A_network, NRMSE_SC2_A_clusteredSM, NRMSE_SC2_A_clusteredGSM;...
    NRMSE_SC2_B_network, NRMSE_SC2_B_clusteredSM, NRMSE_SC2_B_clusteredGSM;...
    NRMSE_SC2_C_network, NRMSE_SC2_C_clusteredSM, NRMSE_SC2_C_clusteredGSM;...
    NRMSE_SC2_D_network, NRMSE_SC2_D_clusteredSM, NRMSE_SC2_D_clusteredGSM];

%% Definition of activity thresholds for ground truth (Speaker-dependent!)
gt_thresh = 10^(-3)*[1;1;1;1;1;1;.5];

%% Grid for activity thresholds of MNICA
mnica_thresh = (0:.001:30).*10^(-2);
smmnica_thresh = 0;
gsmmnica_thresh = 0;

%% Extract Voice Activity Patterns for each Scenario 
%Active, if block energy > gt_thrsh, then manual correction 
SC1_B_VAP = (MNICA_SC1_B>gt_thresh(1));
SC1_A_VAP = (MNICA_SC1_A>gt_thresh(2));
SC1_C_VAP = (MNICA_SC1_C>gt_thresh(3));


SC2_B_VAP = (MNICA_SC2_B>gt_thresh(4));
SC2_A_VAP = (MNICA_SC2_A>gt_thresh(5));
SC2_C_VAP = (MNICA_SC2_C>gt_thresh(6));
SC2_D_VAP = (MNICA_SC2_D>gt_thresh(7));

%Manual correction of the VAPs:
SC1_A_VAP([874, 885:888, 1874, 1885:1888, 2874, 2885:2888]) = [1 0 0 0 0 ...
    1 0 0 0 0 1 0 0 0 0];
SC1_C_VAP([6:23, 116:117, 81, 195:202, 243, 283:291, 373:394, 470:475, ...
    564:583, 659:661, 817, 818, 841, 929:959,...
    1006:1023, 1116:1117, 1081, 1195:1202, 1243, 1283:1291, 1373:1394, 1470:1475, ...
    1564:1583, 1659:1661, 1817, 1818, 1841, 1929:1959,...
    2006:2023, 2116:2117, 2081, 2195:2202, 2243, 2283:2291, 2373:2394, 2470:2475, ...
    2564:2583, 2659:2661, 2817, 2818, 2841, 2929:2959]) ...
    = [zeros(1,20), 1, zeros(1,8), 1, zeros(1,9), zeros(1,22), ...
    zeros(1,6), zeros(1,20), 0,0,0,1,1, zeros(1, 32),...
    zeros(1,20), 1, zeros(1,8), 1, zeros(1,9), zeros(1,22), ...
    zeros(1,6), zeros(1,20), 0,0,0,1,1, zeros(1, 32),...
    zeros(1,20), 1, zeros(1,8), 1, zeros(1,9), zeros(1,22), ...
    zeros(1,6), zeros(1,20), 0,0,0,1,1, zeros(1, 32)];
SC2_D_VAP([57, 539, 330:331, 351, 778 955, 1057, 1539, 1330:1331, 1351,...
    1778 1955, 2057, 2539, 2330:2331, 2351, 2778 2955]) = [0, 0, ones(1,3),...
    0, 0, 0, 0, ones(1,3), 0, 0, 0, 0, ones(1,3), 0, 0];
SC2_A_VAP([874, 885:888, 1874, 1885:1888, 2874, 2885:2888]) = [1 0 0 0 0 ...
    1 0 0 0 0 1 0 0 0 0];
SC2_C_VAP([6:23, 116:117, 81, 195:202, 243, 283:291, 373:394, 470:475, ...
    564:583, 659:661, 817, 818, 841, 929:959,...
    1006:1023, 1116:1117, 1081, 1195:1202, 1243, 1283:1291, 1373:1394, 1470:1475, ...
    1564:1583, 1659:1661, 1817, 1818, 1841, 1929:1959,...
    2006:2023, 2116:2117, 2081, 2195:2202, 2243, 2283:2291, 2373:2394, 2470:2475, ...
    2564:2583, 2659:2661, 2817, 2818, 2841, 2929:2959]) ...
    = [zeros(1,20), 1, zeros(1,8), 1, zeros(1,9), zeros(1,22), ...
    zeros(1,6), zeros(1,20), 0,0,0,1,1, zeros(1, 32),...
    zeros(1,20), 1, zeros(1,8), 1, zeros(1,9), zeros(1,22), ...
    zeros(1,6), zeros(1,20), 0,0,0,1,1, zeros(1, 32),...
    zeros(1,20), 1, zeros(1,8), 1, zeros(1,9), zeros(1,22), ...
    zeros(1,6), zeros(1,20), 0,0,0,1,1, zeros(1, 32)];


SC1_B_VAP_network = (repmat(MNICA_SC1_network(3,:),length(mnica_thresh),1 )>(max(MNICA_SC1_network(3,:)).*mnica_thresh)');
SC1_A_VAP_network = (repmat(MNICA_SC1_network(1,:),length(mnica_thresh),1 )>(max(MNICA_SC1_network(1,:)).*mnica_thresh)');
SC1_C_VAP_network = (repmat(MNICA_SC1_network(2,:),length(mnica_thresh),1 )>(max(MNICA_SC1_network(2,:)).*mnica_thresh)');

SC1_B_VAP_clusteredSM = (repmat(SMMNICA_SC1_B_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC1_B_clust).*smmnica_thresh)');
SC1_A_VAP_clusteredSM = (repmat(SMMNICA_SC1_A_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC1_A_clust).*smmnica_thresh)');
SC1_C_VAP_clusteredSM = (repmat(SMMNICA_SC1_C_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC1_C_clust).*smmnica_thresh)');

SC1_B_VAP_clusteredGSM = (repmat(GSMMNICA_SC1_B_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC1_B_clust).*gsmmnica_thresh)');
SC1_A_VAP_clusteredGSM = (repmat(GSMMNICA_SC1_A_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC1_A_clust).*gsmmnica_thresh)');
SC1_C_VAP_clusteredGSM = (repmat(GSMMNICA_SC1_C_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC1_C_clust).*gsmmnica_thresh)');

SC2_D_VAP_network = (repmat(MNICA_SC2_network(1,:),length(mnica_thresh),1 )>(max(MNICA_SC2_network(1,:)).*mnica_thresh)');
SC2_B_VAP_network = (repmat(MNICA_SC2_network(4,:),length(mnica_thresh),1 )>(max(MNICA_SC2_network(4,:)).*mnica_thresh)');
SC2_A_VAP_network = (repmat(MNICA_SC2_network(2,:),length(mnica_thresh),1 )>(max(MNICA_SC2_network(2,:)).*mnica_thresh)');
SC2_C_VAP_network = (repmat(MNICA_SC2_network(3,:),length(mnica_thresh),1 )>(max(MNICA_SC2_network(3,:)).*mnica_thresh)');

SC2_D_VAP_clusteredSM = (repmat(SMMNICA_SC2_D_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC2_D_clust).*smmnica_thresh)');
SC2_B_VAP_clusteredSM = (repmat(SMMNICA_SC2_B_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC2_B_clust).*smmnica_thresh)');
SC2_A_VAP_clusteredSM = (repmat(SMMNICA_SC2_A_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC2_A_clust).*smmnica_thresh)');
SC2_C_VAP_clusteredSM = (repmat(SMMNICA_SC2_C_clust, length(smmnica_thresh),1)>(max(SMMNICA_SC2_C_clust).*smmnica_thresh)');

SC2_D_VAP_clusteredGSM = (repmat(GSMMNICA_SC2_D_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC2_D_clust).*gsmmnica_thresh)');
SC2_B_VAP_clusteredGSM = (repmat(GSMMNICA_SC2_B_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC2_B_clust).*gsmmnica_thresh)');
SC2_A_VAP_clusteredGSM = (repmat(GSMMNICA_SC2_A_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC2_A_clust).*gsmmnica_thresh)');
SC2_C_VAP_clusteredGSM = (repmat(GSMMNICA_SC2_C_clust, length(gsmmnica_thresh),1)>(max(GSMMNICA_SC2_C_clust).*gsmmnica_thresh)');

%% Selection of relevant parts for the different scenarios
SC1_B_VAP = SC1_B_VAP(1:sc1_length);
SC1_A_VAP = SC1_A_VAP(1:sc1_length);
SC1_C_VAP = SC1_C_VAP(1:sc1_length);


SC2_B_VAP = SC2_B_VAP(1:sc2_length);
SC2_A_VAP = SC2_A_VAP(1:sc2_length);
SC2_C_VAP = SC2_C_VAP(1:sc2_length);
SC2_D_VAP = SC2_D_VAP(1:sc2_length);

SC1_B_VAP_network = SC1_B_VAP_network(:, 1:sc1_length);
SC1_A_VAP_network = SC1_A_VAP_network(:, 1:sc1_length);
SC1_C_VAP_network = SC1_C_VAP_network(:, 1:sc1_length);

SC2_D_VAP_network = SC2_D_VAP_network(:, 1:sc2_length);
SC2_B_VAP_network = SC2_B_VAP_network(:, 1:sc2_length);
SC2_A_VAP_network = SC2_A_VAP_network(:, 1:sc2_length);
SC2_C_VAP_network = SC2_C_VAP_network(:, 1:sc2_length);

SC1_B_VAP_clusteredSM = SC1_B_VAP_clusteredSM(1:sc1_length);
SC1_A_VAP_clusteredSM = SC1_A_VAP_clusteredSM(1:sc1_length);
SC1_C_VAP_clusteredSM = SC1_C_VAP_clusteredSM(1:sc1_length);

SC2_D_VAP_clusteredSM = SC2_D_VAP_clusteredSM(1:sc2_length);
SC2_B_VAP_clusteredSM = SC2_B_VAP_clusteredSM(1:sc2_length);
SC2_A_VAP_clusteredSM = SC2_A_VAP_clusteredSM(1:sc2_length);
SC2_C_VAP_clusteredSM = SC2_C_VAP_clusteredSM(1:sc2_length);

SC1_B_VAP_clusteredGSM = SC1_B_VAP_clusteredGSM(1:sc1_length);
SC1_A_VAP_clusteredGSM = SC1_A_VAP_clusteredGSM(1:sc1_length);
SC1_C_VAP_clusteredGSM = SC1_C_VAP_clusteredGSM(1:sc1_length);

SC2_D_VAP_clusteredGSM = SC2_D_VAP_clusteredGSM(1:sc2_length);
SC2_B_VAP_clusteredGSM = SC2_B_VAP_clusteredGSM(1:sc2_length);
SC2_A_VAP_clusteredGSM = SC2_A_VAP_clusteredGSM(1:sc2_length);
SC2_C_VAP_clusteredGSM = SC2_C_VAP_clusteredGSM(1:sc2_length);

%% Probability of correct decision for MNICA (to select the best threshold)
pcd_SC1_B_network = sum(repmat(SC1_B_VAP, length(mnica_thresh),1)==SC1_B_VAP_network,2)/sc1_length;
pcd_SC1_A_network = sum(repmat(SC1_A_VAP, length(mnica_thresh),1)==SC1_A_VAP_network,2)/sc1_length;
pcd_SC1_C_network = sum(repmat(SC1_C_VAP, length(mnica_thresh),1)==SC1_C_VAP_network,2)/sc1_length;

pcd_SC2_D_network = sum(repmat(SC2_D_VAP, length(mnica_thresh),1)==SC2_D_VAP_network,2)/sc2_length;
pcd_SC2_B_network = sum(repmat(SC2_B_VAP, length(mnica_thresh),1)==SC2_B_VAP_network,2)/sc2_length;
pcd_SC2_A_network = sum(repmat(SC2_A_VAP, length(mnica_thresh),1)==SC2_A_VAP_network,2)/sc2_length;
pcd_SC2_C_network = sum(repmat(SC2_C_VAP, length(mnica_thresh),1)==SC2_C_VAP_network,2)/sc2_length;

%% Probability of correct decision for SMM-NICA and GSSM-NICA (for all different thresholds)
pcd_SC1_B_clusteredSM = sum(repmat(SC1_B_VAP, length(smmnica_thresh),1)==SC1_B_VAP_clusteredSM,2)/sc1_length;
pcd_SC1_A_clusteredSM = sum(repmat(SC1_A_VAP, length(smmnica_thresh),1)==SC1_A_VAP_clusteredSM,2)/sc1_length;
pcd_SC1_C_clusteredSM = sum(repmat(SC1_C_VAP, length(smmnica_thresh),1)==SC1_C_VAP_clusteredSM,2)/sc1_length;

pcd_SC2_D_clusteredSM = sum(repmat(SC2_D_VAP, length(smmnica_thresh),1)==SC2_D_VAP_clusteredSM,2)/sc2_length;
pcd_SC2_B_clusteredSM = sum(repmat(SC2_B_VAP, length(smmnica_thresh),1)==SC2_B_VAP_clusteredSM,2)/sc2_length;
pcd_SC2_A_clusteredSM = sum(repmat(SC2_A_VAP, length(smmnica_thresh),1)==SC2_A_VAP_clusteredSM,2)/sc2_length;
pcd_SC2_C_clusteredSM = sum(repmat(SC2_C_VAP, length(smmnica_thresh),1)==SC2_C_VAP_clusteredSM,2)/sc2_length;

pcd_SC1_B_clusteredGSM = sum(repmat(SC1_B_VAP, length(gsmmnica_thresh),1)==SC1_B_VAP_clusteredGSM,2)/sc1_length;
pcd_SC1_A_clusteredGSM = sum(repmat(SC1_A_VAP, length(gsmmnica_thresh),1)==SC1_A_VAP_clusteredGSM,2)/sc1_length;
pcd_SC1_C_clusteredGSM = sum(repmat(SC1_C_VAP, length(gsmmnica_thresh),1)==SC1_C_VAP_clusteredGSM,2)/sc1_length;

pcd_SC2_D_clusteredGSM = sum(repmat(SC2_D_VAP, length(gsmmnica_thresh),1)==SC2_D_VAP_clusteredGSM,2)/sc2_length;
pcd_SC2_B_clusteredGSM = sum(repmat(SC2_B_VAP, length(gsmmnica_thresh),1)==SC2_B_VAP_clusteredGSM,2)/sc2_length;
pcd_SC2_A_clusteredGSM = sum(repmat(SC2_A_VAP, length(gsmmnica_thresh),1)==SC2_A_VAP_clusteredGSM,2)/sc2_length;
pcd_SC2_C_clusteredGSM = sum(repmat(SC2_C_VAP, length(gsmmnica_thresh),1)==SC2_C_VAP_clusteredGSM,2)/sc2_length;

%% Select thresholds
[~,mnica_thresh_ind_sc1(1)] = max(pcd_SC1_B_network);
[~,mnica_thresh_ind_sc1(2)] = max(pcd_SC1_A_network);
[~,mnica_thresh_ind_sc1(3)] = max(pcd_SC1_C_network);

[~,mnica_thresh_ind_sc2(1)] = max(pcd_SC2_D_network);
[~,mnica_thresh_ind_sc2(2)] = max(pcd_SC2_B_network);
[~,mnica_thresh_ind_sc2(3)] = max(pcd_SC2_A_network);
[~,mnica_thresh_ind_sc2(4)] = max(pcd_SC2_C_network);


pcds = [pcd_SC1_A_network(mnica_thresh_ind_sc1(2)), pcd_SC1_A_clusteredSM, pcd_SC1_A_clusteredGSM;...
    pcd_SC1_B_network(mnica_thresh_ind_sc1(1)), pcd_SC1_B_clusteredSM, pcd_SC1_B_clusteredGSM;...
    pcd_SC1_C_network(mnica_thresh_ind_sc1(3)), pcd_SC1_C_clusteredSM, pcd_SC1_C_clusteredGSM;...
    pcd_SC2_A_network(mnica_thresh_ind_sc2(3)), pcd_SC2_A_clusteredSM, pcd_SC2_A_clusteredGSM;...
    pcd_SC2_B_network(mnica_thresh_ind_sc2(2)), pcd_SC2_B_clusteredSM, pcd_SC2_B_clusteredGSM;...
    pcd_SC2_C_network(mnica_thresh_ind_sc2(4)), pcd_SC2_C_clusteredSM, pcd_SC2_C_clusteredGSM;...
    pcd_SC2_D_network(mnica_thresh_ind_sc2(1)), pcd_SC2_D_clusteredSM, pcd_SC2_D_clusteredGSM];

%% Probability of false alarm
pfa_SC1_B_network = sum(SC1_B_VAP_network(:, SC1_B_VAP==0)==1,2)./sum(SC1_B_VAP==0);
pfa_SC1_A_network = sum(SC1_A_VAP_network(:, SC1_A_VAP==0)==1,2)./sum(SC1_A_VAP==0);
pfa_SC1_C_network = sum(SC1_C_VAP_network(:, SC1_C_VAP==0)==1,2)./sum(SC1_C_VAP==0);

pfa_SC1_B_network_selected_thresh = pfa_SC1_B_network(mnica_thresh_ind_sc1(1));
pfa_SC1_A_network_selected_thresh = pfa_SC1_A_network(mnica_thresh_ind_sc1(2));
pfa_SC1_C_network_selected_thresh = pfa_SC1_C_network(mnica_thresh_ind_sc1(3));

pfa_SC1_B_clusteredSM = sum(SC1_B_VAP_clusteredSM(:, SC1_B_VAP==0)==1,2)./sum(SC1_B_VAP==0);
pfa_SC1_A_clusteredSM = sum(SC1_A_VAP_clusteredSM(:,SC1_A_VAP==0)==1,2)./sum(SC1_A_VAP==0);
pfa_SC1_C_clusteredSM = sum(SC1_C_VAP_clusteredSM(:, SC1_C_VAP==0)==1,2)./sum(SC1_C_VAP==0);

pfa_SC1_B_clusteredGSM = sum(SC1_B_VAP_clusteredGSM(:, SC1_B_VAP==0)==1,2)./sum(SC1_B_VAP==0);
pfa_SC1_A_clusteredGSM = sum(SC1_A_VAP_clusteredGSM(:,SC1_A_VAP==0)==1,2)./sum(SC1_A_VAP==0);
pfa_SC1_C_clusteredGSM = sum(SC1_C_VAP_clusteredGSM(:, SC1_C_VAP==0)==1,2)./sum(SC1_C_VAP==0);

pfa_SC2_D_network = sum(SC2_D_VAP_network(:, SC2_D_VAP==0)==1,2)./sum(SC2_D_VAP==0);
pfa_SC2_B_network = sum(SC2_B_VAP_network(:, SC2_B_VAP==0)==1,2)./sum(SC2_B_VAP==0);
pfa_SC2_A_network = sum(SC2_A_VAP_network(:, SC2_A_VAP==0)==1,2)./sum(SC2_A_VAP==0);
pfa_SC2_C_network = sum(SC2_C_VAP_network(:, SC2_C_VAP==0)==1,2)./sum(SC2_C_VAP==0);

pfa_SC2_D_network_selected_thresh = pfa_SC2_D_network(mnica_thresh_ind_sc2(1));
pfa_SC2_B_network_selected_thresh = pfa_SC2_B_network(mnica_thresh_ind_sc2(2));
pfa_SC2_A_network_selected_thresh = pfa_SC2_A_network(mnica_thresh_ind_sc2(3));
pfa_SC2_C_network_selected_thresh = pfa_SC2_C_network(mnica_thresh_ind_sc2(4));

pfa_SC2_D_clusteredSM = sum(SC2_D_VAP_clusteredSM(:,SC2_D_VAP==0)==1,2)./sum(SC2_D_VAP==0);
pfa_SC2_B_clusteredSM = sum(SC2_B_VAP_clusteredSM(:, SC2_B_VAP==0)==1,2)./sum(SC2_B_VAP==0);
pfa_SC2_A_clusteredSM = sum(SC2_A_VAP_clusteredSM(:, SC2_A_VAP==0)==1,2)./sum(SC2_A_VAP==0);
pfa_SC2_C_clusteredSM = sum(SC2_C_VAP_clusteredSM(:, SC2_C_VAP==0)==1,2)./sum(SC2_C_VAP==0);

pfa_SC2_D_clusteredGSM = sum(SC2_D_VAP_clusteredGSM(:,SC2_D_VAP==0)==1,2)./sum(SC2_D_VAP==0);
pfa_SC2_B_clusteredGSM = sum(SC2_B_VAP_clusteredGSM(:, SC2_B_VAP==0)==1,2)./sum(SC2_B_VAP==0);
pfa_SC2_A_clusteredGSM = sum(SC2_A_VAP_clusteredGSM(:, SC2_A_VAP==0)==1,2)./sum(SC2_A_VAP==0);
pfa_SC2_C_clusteredGSM = sum(SC2_C_VAP_clusteredGSM(:, SC2_C_VAP==0)==1,2)./sum(SC2_C_VAP==0);

pfas = [pfa_SC1_A_network(mnica_thresh_ind_sc1(2)), pfa_SC1_A_clusteredSM, pfa_SC1_A_clusteredGSM;...
    pfa_SC1_B_network(mnica_thresh_ind_sc1(1)), pfa_SC1_B_clusteredSM, pfa_SC1_B_clusteredGSM;...
    pfa_SC1_C_network(mnica_thresh_ind_sc1(3)), pfa_SC1_C_clusteredSM, pfa_SC1_C_clusteredGSM;...
    pfa_SC2_A_network(mnica_thresh_ind_sc2(3)), pfa_SC2_A_clusteredSM, pfa_SC2_A_clusteredGSM;...
    pfa_SC2_B_network(mnica_thresh_ind_sc2(2)), pfa_SC2_B_clusteredSM, pfa_SC2_B_clusteredGSM;...
    pfa_SC2_C_network(mnica_thresh_ind_sc2(4)), pfa_SC2_C_clusteredSM, pfa_SC2_C_clusteredGSM;...
    pfa_SC2_D_network(mnica_thresh_ind_sc2(1)), pfa_SC2_D_clusteredSM, pfa_SC2_D_clusteredGSM];

%% Probability of missed detection
pmd_SC1_B_network = sum(SC1_B_VAP_network(:, SC1_B_VAP==1)==0,2)./sum(SC1_B_VAP==1);
pmd_SC1_A_network = sum(SC1_A_VAP_network(:, SC1_A_VAP==1)==0,2)./sum(SC1_A_VAP==1);
pmd_SC1_C_network = sum(SC1_C_VAP_network(:, SC1_C_VAP==1)==0,2)./sum(SC1_C_VAP==1);

pmd_SC1_B_network_selected_thresh = pmd_SC1_B_network(mnica_thresh_ind_sc1(1));
pmd_SC1_A_network_selected_thresh = pmd_SC1_A_network(mnica_thresh_ind_sc1(2));
pmd_SC1_C_network_selected_thresh = pmd_SC1_C_network(mnica_thresh_ind_sc1(3));

pmd_SC1_B_clusteredSM = sum(SC1_B_VAP_clusteredSM(:, SC1_B_VAP==1)==0,2)./sum(SC1_B_VAP==1);
pmd_SC1_A_clusteredSM = sum(SC1_A_VAP_clusteredSM(:, SC1_A_VAP==1)==0,2)./sum(SC1_A_VAP==1);
pmd_SC1_C_clusteredSM = sum(SC1_C_VAP_clusteredSM(:, SC1_C_VAP==1)==0,2)./sum(SC1_C_VAP==1);

pmd_SC1_B_clusteredGSM = sum(SC1_B_VAP_clusteredGSM(:, SC1_B_VAP==1)==0,2)./sum(SC1_B_VAP==1);
pmd_SC1_A_clusteredGSM = sum(SC1_A_VAP_clusteredGSM(:, SC1_A_VAP==1)==0,2)./sum(SC1_A_VAP==1);
pmd_SC1_C_clusteredGSM = sum(SC1_C_VAP_clusteredGSM(:, SC1_C_VAP==1)==0,2)./sum(SC1_C_VAP==1);

pmd_SC2_D_network = sum(SC2_D_VAP_network(:, SC2_D_VAP==1)==0,2)./sum(SC2_D_VAP==1);
pmd_SC2_B_network = sum(SC2_B_VAP_network(:, SC2_B_VAP==1)==0,2)./sum(SC1_B_VAP==1);
pmd_SC2_A_network = sum(SC2_A_VAP_network(:, SC2_A_VAP==1)==0,2)./sum(SC1_A_VAP==1);
pmd_SC2_C_network = sum(SC2_C_VAP_network(:, SC2_C_VAP==1)==0,2)./sum(SC2_C_VAP==1);

pmd_SC2_D_network_selected_thresh = pmd_SC2_D_network(mnica_thresh_ind_sc2(1));
pmd_SC2_B_network_selected_thresh = pmd_SC2_B_network(mnica_thresh_ind_sc2(2));
pmd_SC2_A_network_selected_thresh = pmd_SC2_A_network(mnica_thresh_ind_sc2(3));
pmd_SC2_C_network_selected_thresh = pmd_SC2_C_network(mnica_thresh_ind_sc2(4));

pmd_SC2_D_clusteredSM = sum(SC2_D_VAP_clusteredSM(:, SC2_D_VAP==1)==0,2)./sum(SC2_D_VAP==1);
pmd_SC2_B_clusteredSM = sum(SC2_B_VAP_clusteredSM(:, SC2_B_VAP==1)==0,2)./sum(SC2_B_VAP==1);
pmd_SC2_A_clusteredSM = sum(SC2_A_VAP_clusteredSM(:, SC2_A_VAP==1)==0,2)./sum(SC2_A_VAP==1);
pmd_SC2_C_clusteredSM = sum(SC2_C_VAP_clusteredSM(:, SC2_C_VAP==1)==0,2)./sum(SC2_C_VAP==1);

pmd_SC2_D_clusteredGSM = sum(SC2_D_VAP_clusteredGSM(:, SC2_D_VAP==1)==0,2)./sum(SC2_D_VAP==1);
pmd_SC2_B_clusteredGSM = sum(SC2_B_VAP_clusteredGSM(:, SC2_B_VAP==1)==0,2)./sum(SC2_B_VAP==1);
pmd_SC2_A_clusteredGSM = sum(SC2_A_VAP_clusteredGSM(:, SC2_A_VAP==1)==0,2)./sum(SC2_A_VAP==1);
pmd_SC2_C_clusteredGSM = sum(SC2_C_VAP_clusteredGSM(:, SC2_C_VAP==1)==0,2)./sum(SC2_C_VAP==1);

pmds = [pmd_SC1_A_network(mnica_thresh_ind_sc1(2)), pmd_SC1_A_clusteredSM, pmd_SC1_A_clusteredGSM;...
    pmd_SC1_B_network(mnica_thresh_ind_sc1(1)), pmd_SC1_B_clusteredSM, pmd_SC1_B_clusteredGSM;...
    pmd_SC1_C_network(mnica_thresh_ind_sc1(3)), pmd_SC1_C_clusteredSM, pmd_SC1_C_clusteredGSM;...
    pmd_SC2_A_network(mnica_thresh_ind_sc2(3)), pmd_SC2_A_clusteredSM, pmd_SC2_A_clusteredGSM;...
    pmd_SC2_B_network(mnica_thresh_ind_sc2(2)), pmd_SC2_B_clusteredSM, pmd_SC2_B_clusteredGSM;...
    pmd_SC2_C_network(mnica_thresh_ind_sc2(4)), pmd_SC2_C_clusteredSM, pmd_SC2_C_clusteredGSM;...
    pmd_SC2_D_network(mnica_thresh_ind_sc2(1)), pmd_SC2_D_clusteredSM, pmd_SC2_D_clusteredGSM];

%% False Discovery Proportion
fdp_SC1_B_network = sum(SC1_B_VAP_network(mnica_thresh_ind_sc1(1), SC1_B_VAP==0)==1,2)./sum(SC1_B_VAP_network(mnica_thresh_ind_sc1(1),:)==1);
fdp_SC1_A_network = sum(SC1_A_VAP_network(mnica_thresh_ind_sc1(2), SC1_A_VAP==0)==1,2)./sum(SC1_A_VAP_network(mnica_thresh_ind_sc1(2),:)==1);
fdp_SC1_C_network = sum(SC1_C_VAP_network(mnica_thresh_ind_sc1(3), SC1_C_VAP==0)==1,2)./sum(SC1_C_VAP_network(mnica_thresh_ind_sc1(3),:)==1);

fdp_SC1_B_clusteredSM = sum(SC1_B_VAP_clusteredSM(:, SC1_B_VAP==0)==1,2)./sum(SC1_B_VAP_clusteredSM==1);
fdp_SC1_A_clusteredSM = sum(SC1_A_VAP_clusteredSM(:,SC1_A_VAP==0)==1,2)./sum(SC1_A_VAP_clusteredSM==1);
fdp_SC1_C_clusteredSM = sum(SC1_C_VAP_clusteredSM(:, SC1_C_VAP==0)==1,2)./sum(SC1_C_VAP_clusteredSM==1);

fdp_SC1_B_clusteredGSM = sum(SC1_B_VAP_clusteredGSM(:, SC1_B_VAP==0)==1,2)./sum(SC1_B_VAP_clusteredGSM==1);
fdp_SC1_A_clusteredGSM = sum(SC1_A_VAP_clusteredGSM(:,SC1_A_VAP==0)==1,2)./sum(SC1_A_VAP_clusteredGSM==1);
fdp_SC1_C_clusteredGSM = sum(SC1_C_VAP_clusteredGSM(:, SC1_C_VAP==0)==1,2)./sum(SC1_C_VAP_clusteredGSM==1);

fdp_SC2_D_network = sum(SC2_D_VAP_network(mnica_thresh_ind_sc2(1), SC2_D_VAP==0)==1,2)./sum(SC2_D_VAP_network(mnica_thresh_ind_sc2(1),:)==1);
fdp_SC2_B_network = sum(SC2_B_VAP_network(mnica_thresh_ind_sc2(2), SC2_B_VAP==0)==1,2)./sum(SC2_B_VAP_network(mnica_thresh_ind_sc2(2),:)==1);
fdp_SC2_A_network = sum(SC2_A_VAP_network(mnica_thresh_ind_sc2(3), SC2_A_VAP==0)==1,2)./sum(SC2_A_VAP_network(mnica_thresh_ind_sc2(3),:)==1);
fdp_SC2_C_network = sum(SC2_C_VAP_network(mnica_thresh_ind_sc2(4), SC2_C_VAP==0)==1,2)./sum(SC2_C_VAP_network(mnica_thresh_ind_sc2(4),:)==1);

fdp_SC2_D_clusteredSM = sum(SC2_D_VAP_clusteredSM(:,SC2_D_VAP==0)==1,2)./sum(SC2_D_VAP_clusteredSM==1);
fdp_SC2_B_clusteredSM = sum(SC2_B_VAP_clusteredSM(:, SC2_B_VAP==0)==1,2)./sum(SC2_B_VAP_clusteredSM==1);
fdp_SC2_A_clusteredSM = sum(SC2_A_VAP_clusteredSM(:, SC2_A_VAP==0)==1,2)./sum(SC2_A_VAP_clusteredSM==1);
fdp_SC2_C_clusteredSM = sum(SC2_C_VAP_clusteredSM(:, SC2_C_VAP==0)==1,2)./sum(SC2_C_VAP_clusteredSM==1);

fdp_SC2_D_clusteredGSM = sum(SC2_D_VAP_clusteredGSM(:,SC2_D_VAP==0)==1,2)./sum(SC2_D_VAP_clusteredGSM==1);
fdp_SC2_B_clusteredGSM = sum(SC2_B_VAP_clusteredGSM(:, SC2_B_VAP==0)==1,2)./sum(SC2_B_VAP_clusteredGSM==1);
fdp_SC2_A_clusteredGSM = sum(SC2_A_VAP_clusteredGSM(:, SC2_A_VAP==0)==1,2)./sum(SC2_A_VAP_clusteredGSM==1);
fdp_SC2_C_clusteredGSM = sum(SC2_C_VAP_clusteredGSM(:, SC2_C_VAP==0)==1,2)./sum(SC2_C_VAP_clusteredGSM==1);

fdps = [fdp_SC1_A_network, fdp_SC1_A_clusteredSM, fdp_SC1_A_clusteredGSM;...
    fdp_SC1_B_network, fdp_SC1_B_clusteredSM, fdp_SC1_B_clusteredGSM;...
    fdp_SC1_C_network, fdp_SC1_C_clusteredSM, fdp_SC1_C_clusteredGSM;...
    fdp_SC2_A_network, fdp_SC2_A_clusteredSM, fdp_SC2_A_clusteredGSM;...
    fdp_SC2_B_network, fdp_SC2_B_clusteredSM, fdp_SC2_B_clusteredGSM;...
    fdp_SC2_C_network, fdp_SC2_C_clusteredSM, fdp_SC2_C_clusteredGSM;...
    fdp_SC2_D_network, fdp_SC2_D_clusteredSM, fdp_SC2_D_clusteredGSM];
fdps(fdps==0) = 0;

%% Translation into latex tables
latex_rhos= latex(vpa(rhos,4));
latex_pcds= latex(vpa(pcds,4));
latex_pfas= latex(vpa(pfas,4));
latex_pmds= latex(vpa(pmds,4));
latex_fdps= latex(vpa(fdps,4));
latex_NRMSEs = latex(vpa(NRMSEs,5));
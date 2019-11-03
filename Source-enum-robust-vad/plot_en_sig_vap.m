%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plots energy signatures and VAPs for a given speaker from one of the
%scenarios.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define the speaker to be plotted
speaker_name = '1B';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot the energy signatures and VAPs
switch speaker_name
    case '1A'
        figure('Name', 'Sc. 1: Signal A', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC1_A(1:sc1_length), 'LineWidth',2)
        plot(SC1_A_VAP*max(MNICA_SC1_A(1:sc1_length)),'LineWidth', 2)
        hold off
        legend('Energy Signature', 'VAP')
        title('Ground Truth')
        subplot(4,1,2)
        hold on
        plot(MNICA_SC1_network(1,(1:sc1_length)), 'LineWidth',2)
        plot(SC1_A_VAP_network(mnica_thresh_ind_sc1(2),:)*max(MNICA_SC1_network(1,(1:sc1_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC1_A_clust(1:sc1_length), 'LineWidth',2)
        plot(SC1_A_VAP_clusteredSM*max(SMMNICA_SC1_A_clust(1:sc1_length)), 'LineWidth',2)
        hold off
        title('SMM-NICA')
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC1_A_clust(1:sc1_length), 'LineWidth',2)
        plot(SC1_A_VAP_clusteredGSM*max(GSMMNICA_SC1_A_clust(1:sc1_length)), 'LineWidth',2)
        hold off
        title('GSMM-NICA')
    case '1B'
        figure('Name', 'Sc. 1: Signal B', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC1_B(1:sc1_length), 'LineWidth',2)
        plot(SC1_B_VAP*max(MNICA_SC1_B(1:sc1_length)), 'LineWidth',2)
        hold off
        legend('Energy Signature', 'VAP')
        title('Ground Truth')
        subplot(4,1,2)
        hold on
        plot(MNICA_SC1_network(3,(1:sc1_length)), 'LineWidth',2)
        plot(SC1_B_VAP_network(mnica_thresh_ind_sc1(1),:)*max(MNICA_SC1_network(3,(1:sc1_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC1_B_clust(1:sc1_length), 'LineWidth',2)
        plot(SC1_B_VAP_clusteredSM*max(SMMNICA_SC1_B_clust(1:sc1_length)), 'LineWidth',2)
        hold off
        title('SMM-NICA')
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC1_B_clust(1:sc1_length), 'LineWidth',2)
        plot(SC1_B_VAP_clusteredGSM*max(GSMMNICA_SC1_B_clust(1:sc1_length)), 'LineWidth',2)
        hold off
        title('GSMM-NICA')
    case '1C'
        figure('Name', 'Sc. 1: Signal C', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC1_C(1:sc1_length), 'LineWidth',2)
        plot(SC1_C_VAP*max(MNICA_SC1_C(1:sc1_length)), 'LineWidth',2)
        hold off
        title('Ground Truth')
        legend('Energy Signature', 'VAP')
        subplot(4,1,2)
        hold on
        plot(MNICA_SC1_network(2,(1:sc1_length)), 'LineWidth',2)
        plot(SC1_C_VAP_network(mnica_thresh_ind_sc1(3),:)*max(MNICA_SC1_network(2,(1:sc1_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC1_C_clust(1:sc1_length), 'LineWidth',2)
        plot(SC1_C_VAP_clusteredSM*max(SMMNICA_SC1_C_clust(1:sc1_length)), 'LineWidth',2)
        hold off
        title('SMM-NICA')
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC1_C_clust(1:sc1_length), 'LineWidth',2)
        plot(SC1_C_VAP_clusteredGSM*max(GSMMNICA_SC1_C_clust(1:sc1_length)), 'LineWidth',2)
        hold off
        title('GSMM-NICA')
        
    case '2A'
        figure('Name', 'Sc. 2: Signal A', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC2_A(1:sc2_length), 'LineWidth',2)
        plot(SC2_A_VAP*max(MNICA_SC2_A(1:sc2_length)), 'LineWidth',2)
        legend('Energy Signature', 'VAP')
        hold off
        title('Ground Truth')
        subplot(4,1,2)
        hold on
        plot(MNICA_SC2_network(2,(1:sc2_length)), 'LineWidth',2)
        plot(SC2_A_VAP_network(mnica_thresh_ind_sc2(3),:)*max(MNICA_SC2_network(2,(1:sc2_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC2_A_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_A_VAP_clusteredSM*max(SMMNICA_SC2_A_clust(1:sc2_length)), 'LineWidth',2)
        title('SMM-NICA')
        hold off
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC2_A_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_A_VAP_clusteredGSM*max(GSMMNICA_SC2_A_clust(1:sc2_length)), 'LineWidth',2)
        hold off
        title('GSMM-NICA')
        
    case '2B'
        figure('Name', 'Sc. 2: Signal B', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC2_B(1:sc2_length), 'LineWidth',2)
        plot(SC2_B_VAP*max(MNICA_SC2_B(1:sc2_length)), 'LineWidth',2)
        hold off
        title('Ground Truth')
        legend('Energy Signature', 'VAP')
        subplot(4,1,2)
        hold on
        plot(MNICA_SC2_network(4,(1:sc2_length)), 'LineWidth',2)
        plot(SC2_B_VAP_network(mnica_thresh_ind_sc2(2),:)*max(MNICA_SC2_network(4,(1:sc2_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC2_B_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_B_VAP_clusteredSM*max(SMMNICA_SC2_B_clust(1:sc2_length)), 'LineWidth',2)
        hold off
        title('SMM-NICA')
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC2_B_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_B_VAP_clusteredGSM*max(GSMMNICA_SC2_B_clust(1:sc2_length)), 'LineWidth',2)
        hold off
        title('GSMM-NICA')

    case '2C'
        figure('Name', 'Sc. 2: Signal C', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC2_C(1:sc2_length), 'LineWidth',2)
        plot(SC2_C_VAP*max(MNICA_SC2_C(1:sc2_length)), 'LineWidth',2)
        title('Ground Truth')
        legend('Energy Signature', 'VAP')
        hold off
        subplot(4,1,2)
        hold on
        plot(MNICA_SC2_network(3,(1:sc2_length)), 'LineWidth',2)
        plot(SC2_C_VAP_network(mnica_thresh_ind_sc2(4),:)*max(MNICA_SC2_network(3,(1:sc2_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC2_C_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_C_VAP_clusteredSM*max(SMMNICA_SC2_C_clust(1:sc2_length)), 'LineWidth',2)
        hold off
        title('SMM-NICA')
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC2_C_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_C_VAP_clusteredGSM*max(GSMMNICA_SC2_C_clust(1:sc2_length)), 'LineWidth',2)
        hold off
        title('GSMM-NICA')
        
    case '2D'
        figure('Name', 'Sc. 2: Signal D', 'NumberTitle', 'off')
        subplot(4,1,1)
        hold on
        plot(MNICA_SC2_D(1:sc2_length), 'LineWidth',2)
        plot(SC2_D_VAP*max(MNICA_SC2_D(1:sc2_length)), 'LineWidth',2)
        title('Ground Truth')
        legend('Energy Signature', 'VAP')
        hold off
        subplot(4,1,2)
        hold on
        plot(MNICA_SC2_network(1,(1:sc2_length)), 'LineWidth',2)
        plot(SC2_D_VAP_network(mnica_thresh_ind_sc2(1),:)*max(MNICA_SC2_network(1,(1:sc2_length))), 'LineWidth',2)
        hold off
        title('M-NICA')
        subplot(4,1,3)
        hold on
        plot(SMMNICA_SC2_D_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_D_VAP_clusteredSM*max(SMMNICA_SC2_D_clust(1:sc2_length)), 'LineWidth',2)
        hold off
        title('SMM-NICA')
        subplot(4,1,4)
        hold on
        plot(GSMMNICA_SC2_D_clust(1:sc2_length), 'LineWidth',2)
        plot(SC2_D_VAP_clusteredGSM*max(GSMMNICA_SC2_D_clust(1:sc2_length)), 'LineWidth',2)
        title('GSSM-NICA')
        hold off
        legend('Energy Signature', 'VAP')

end

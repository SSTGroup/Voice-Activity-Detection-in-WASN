% Implementation of the method and its competitors from [1]

%     Copyright (C) 2019  Martin Gölz (as long as not indicated differently 
%     in individual files) 
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
%[1] T. Hasija, M. Gölz, M. Muma, Peter J. Schreier and Abdelhak M. Zoubir,
%"Source Enumeration and Robust Voice Activity Detection in Wireless
%Acoustic Sensor Networks", Asilomar conference on signals, systems and
%computers, 2019.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%IMPORTANT NOTES
%   - Scenario 2 can only be run after Scenario 1 has been executed. 
%   - The group sparse VAD method right now uses the cluserting result from saved mat 
%     file -> this will be updated in future version of the code where the 
%     user can generate own scenarios and clustering result is 
%     automatically fed to the group sparse VAD method  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear variables
clc

%% Tracking of computation time
t_network = zeros(2,1);
t_clusteredSM = zeros(7,1);
t_clusteredGSM = zeros(7,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Predefined Parameters
stat_int_sec = 30; %in ms
fs = 16000; %in Hz
stat_int = 30*10e-4*16*10e2; %Stationarity interval of speech

mics_per_nodes = 3;

%Set here the block length! For regenerating the results from the paper for		block_length = 20;
%scenario 1, set it to 10, for scenario 2 to 20.		
block_length = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for Scenario 1
%Parameters depending on scenarios
num_sourc = 3;
num_active_nodes = 10;
num_active_mics = mics_per_nodes*num_active_nodes;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Scenario 1 References with all sources separately active and no noise
scenario_1_network_separated;
clear mics;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Scenario 1 Using all Mics with and without noise
scenario_1_network;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scenario 1 source enumeration and Clustering 
scenario='scen_1'; 
clustering;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scenario 1 Clustered
scenario_1_clustered;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 

%Parameters for Scenario 2
%Parameters depending on scenarios
num_sourc = 4;
num_active_nodes = 15;
num_active_mics = mics_per_nodes*num_active_nodes;
block_length = 20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Scenario 2 References with all sources separately active and no noise
scenario_2_network_separated;
clear mics;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scenario 2 Using all Mics and without noise (?)
scenario_2_network;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scenario 2 source enumeration and Clustering 
scenario='scen_2'; 
clustering;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scenario 2 Clustered
scenario_2_clustered;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
performance_measures;

%Select the speaker you want to plot the energy signature and VAP for in
%this script
%plot_en_sig_vap;
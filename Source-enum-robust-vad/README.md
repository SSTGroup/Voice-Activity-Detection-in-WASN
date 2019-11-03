###############
# Description #
###############

This matlab package contains files implementing the technique developed for source enumeration, node clustering around a dominant source and robust voice activity detection in WASN in [1]. 

Requires MATLAB version 2018 or later.

############
# Abstract #
############

We propose a robust technique for multi-speaker voice activity detection and source enumeration in wireless acoustic sensor networks (WASN). The performance of the traditional technique based on multiplicative nonnegative ICA decreases as the number of speaker increases. The proposed technique first clusters the nodes that observe a single speaker as dominant source and then estimates the voice activity of each speaker by introducing a block-sparsity penalizing term in the unmixing problem. We validate the results using a WASN with four speakers observed by 15 nodes in presence of two impulsive noise sources.

##############
# File Usage #
##############

main.m - Runs scenario 1 and scenario 2 described in the paper. To run it: 
- Add folders applied_methods, data-scenario1, data-scenario2 and performance_analysis to the MATLAB path.
- Set the block-length for the group sparse approach in line 47 of main.m
- Then run main
- After termination, set the desired speaker you want to plot energy signature and VAP for in line 6 of plot_en_sig_vap.m (first number of scenario, then speaker number)
- You have reproduced the results from the paper.

To generate your own scenario, please download the HANDiCAMS database at the following link and use join_micsigs.m:
https://www2.nt.tu-darmstadt.de/data/clustered_vad_data.zip 
 
###########
# Contact #
###########

In case of questions, suggestions, problems etc. please send an email.

Tanuj Hasija:
tanuj.hasija@sst.upb.de

Martin Gölz
mgoelz@spg.tu-darmstadt.de

This matlab package is hosted at:
https://github.com/SSTGroup//Voice-Activity-Detection-in-WASN/

##############
# References #
##############

[[1]] T. Hasija, M. Gölz, M. Muma, P. J. Schreier and A. M. Zoubir, "Source Enumeration and Robust Voice ActivityDetection in Wireless Acoustic Sensor Networks," Proc. Asilomar Conf. Signals Syst. Computers, Pacific Grove, CA, USA, November 2019.

###################
# Acknowledgements #
###################

This research was supported by the German Research Foundation (DFG) under grants SCHR 1384/3-2and ZO 215/17-2. The WASN speech dataset has been generated within the EU FET-Open ProjectHANDiCAMS (GA no. 323944).
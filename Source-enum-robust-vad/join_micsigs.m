%   File: clustering.m
%   Copyright (c) <2019> <University of Paderborn>
%   Signal and System Theory Group, Univ. of Paderborn, http://sst.upb.de
%   https://github.com/SSTGroup/Voice-Activity-Detection-in-WASN
%
%   Originally adapted from WASN speech dataset code that has been generated 
%   within the EU FET-Open Project HANDiCAMS (GA no. 323944).
%
%   Permission is hereby granted, free of charge, to any person
%   obtaining a copy of this software and associated documentation
%   files (the "Software"), to deal in the Software without restriction,
%   including without limitation the rights to use, copy, modify and
%   merge the Software, subject to the following conditions:
%
%   1.) The Software is used for non-commercial research and
%       education purposes.
%
%   2.) The above copyright notice and this permission notice shall be
%       included in all copies or substantial portions of the Software.
%
%   3.) Publication, Distribution, Sublicensing, and/or Selling of
%       copies or parts of the Software requires special agreements
%       with the University of Paderborn and is in general not permitted.
%
%   4.) Modifications or contributions to the software must be
%       published under this license. The University of Paderborn
%       is granted the non-exclusive right to publish modifications
%       or contributions in future versions of the Software free of charge.
%
%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
%   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
%   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
%   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
%   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
%   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
%   OTHER DEALINGS IN THE SOFTWARE.
%
%   Persons using the Software are encouraged to notify the
%   Signal and System Theory Group at the University of Paderborn
%   about bugs. Please reference the Software in your publications
%   if it was used for them.
%
switch lower(scenario)
    case 'scen_1'
        source_on(1)=0; %set to 1 if source 1 should be incorporated
        source_on(2)=0;
        source_on(3)=0;
        source_on(4)=0;
        source_on(5)=1;
        source_on(6)=0;
        source_on(7)=1;
        source_on(8)=1;
        source_on(9)=0;
        source_on(10)=0;
        source_on(11)=0;
        source_on(12)=0;
        
    case 'scen_2'
        source_on(1)=0;
        source_on(2)=1;
        source_on(3)=0;
        source_on(4)=1;
        source_on(5)=1;
        source_on(6)=0;
        source_on(7)=1;
        source_on(8)=1;
        source_on(9)=0;
        source_on(10)=0;
        source_on(11)=1;
        source_on(12)=1;
    otherwise
        error('Unknown scenario');
end

uncorrelatednoise_on=1; %set to 1 to add some spatially uncorrelated noise to the microphone signals (this is a percentage of the average microphone signal power over all microphones)

mics=[];
for k=1:length(source_on)
    if source_on(k)==1;
        load(['source' num2str(k)])
        if ~isempty(mics)
            mics=mics+mic;
        else
            mics=mic;
        end
    end
end

% Increase the total observation time to 90s by duplicating the clean data 3 times
mics_concat = [mics;mics;mics];
mics = mics_concat;

if uncorrelatednoise_on==1
    %add spatially uncorrelated noise (babble noise + white noise)
    %noisepow1=0.04; %percentage of average microphone signal power which defines the power of uncorrelated noise source 1 (babble noise)
    noisepow1=0.00;
    noisepow2=0.05; %percentage of average microphone signal power which defines the power of uncorrelated noise source 2 (white noise)
    micvars=median(var(squeeze(mics(:,1,:))));
    %0.009; %Not based on mic signal processing anymore in the new version. old version: median(var(squeeze(mics(:,1,:))));
    [babblenoise,fs]=audioread('Babble_noise.wav');
    babblenoise=resample(babblenoise,fs_target,fs);
    babblenoise=babblenoise/std(babblenoise);
    counter=1;
    for j=1:size(mics,3)
        for l=1:size(mics,2)
            mics(:,l,j)=mics(:,l,j)+sqrt(noisepow1*micvars)*babblenoise(counter:counter+size(mics,1)-1)+sqrt(noisepow2*micvars)*randn(size(mics,1),1);
            mics(:,l,j)=0.99*mics(:,l,j)/max(abs(mics(:,l,j))); %max amplitude is 1 (avoid clipping when writing it as a wav file)
            counter=counter+fs_target; %shift in babble noise file such that babble noise is uncorrelated in each mic
        end
    end
end

switch lower(scenario)
    case 'scen_1'
        % Parameters for scenario 1
        sensors= [8,11,5,6,15,3,9,2,19,1]; % Sensors included from original Handicams database
        t_samples = 15; % Time in seconds
        M = t_samples*fs_target; %number of time points
        mics = mics(1:M,:,sensors);
        save('micsignals_scen_1','mics','fs_target')
    case 'scen_2'
        % Parameters for scenario 2
        sensors= [3,9,13,8,11,14,5,6,15,2,4,12,17,19,1]; % Sensors included from original Handicams database
        t_samples = 30; % Time in seconds
        M = t_samples*fs_target; %number of time points
        mics = mics(1:M,:,sensors);
        save('micsignals_scen_2','mics','fs_target')
    otherwise
        error('Unknown scenario');
end
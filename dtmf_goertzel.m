clear all;

% Read in the sound data
[sounddata,Fsound] = audioread('dtmfA1.wav');
Fs  = 8000;       % Sampling frequency 8 kHz

if Fsound == Fs
    disp('The soundinput has the correct sampling frequency')
else
    disp('The soundinput does not match the 8KHz sampling frequency')
    disp('Therefor the script is aborted')
    return
end

lfg = [697 770 852 941]; % Low frequency group
hfg = [1209 1336 1477];  % High frequency group

% Generate 12 frequency pairs
frequencypairs   = [reshape(ones(3,1)*lfg,1,12); repmat(hfg,1,4)];

% The minimum duration of a DTMF signal defined by the ITU standard is 40
% ms. Therefore, there are at most 0.04 x 8000 = 320 samples available for
% estimation and detection. The DTMF decoder needs to estimate the
% frequencies contained in these short signals. 
%
% One common approach to this estimation problem is to compute the
% Discrete-Time Fourier Transform (DFT) samples close to the seven
% fundamental tones. For a DFT-based solution, it has been shown that using
% 205 samples in the frequency domain minimizes the error between the
% original frequencies and the points at which the DFT is estimated.
Nsamples = 205;
original_frequencies = [lfg(:);hfg(:)];  % Original frequencies

k = round((original_frequencies/Fs)*Nsamples);  % Indices of the DFT
estim_f = round(k*Fs/Nsamples);      % Frequencies at which the DFT is estimated


stem(sounddata)
%take subset from sounddata. from first DTMF keypress
sampledata = sounddata(2200: 2200+Nsamples);
%pause
stem(sampledata)
%pause
dft_data = goertzel(sampledata, k);
stem(original_frequencies, abs(dft_data));

%layout of plot
ax = gca; %handle to the current axes
ax.XTick = original_frequencies;
xlabel('Frequency (Hz)')
title('DFT Magnitude')
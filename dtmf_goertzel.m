%Matlab code analyzing sound for Dual Tone Multi Frequency (DTMF) tones.
%I have reused a large part of this matlab code: http://nl.mathworks.com/help/signal/examples/dft-estimation-with-the-goertzel-algorithm.html
%
%Soundfile dtmfA1.wav downloaded from: http://www.ee.columbia.edu/~dpwe/sounds/dtmf/
%http://www.ee.columbia.edu/~dpwe/sounds/dtmf/dtmfA1.wav
%more soundfiles:
%http://www.ee.columbia.edu/~dpwe/sounds/
%

clear all;

% Read in the sound data
%%{
[sounddata,Fsound] = audioread('tone_1.wav');
%}

%{
[sounddata, Fsound] = audioread('dtmfA1.wav');
%}

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

%{
%debugging
stem(sounddata)
pause
%}

%{
%specially for dtmfA1.wav
%take subset from sounddata. from first DTMF keypress
sounddata = sounddata(2200: 2200+Nsamples);
%stem(sampledata)
%pause
%}

dft_data = goertzel(sounddata(1:205), k+1); % Goertzel use 1-based indexing
stem(original_frequencies, abs(dft_data));
%layout of plot
ax = gca; %handle to the current axes
ax.XTick = original_frequencies;
xlabel('Frequency (Hz)')
title('DFT Magnitude')

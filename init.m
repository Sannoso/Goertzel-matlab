%initialize the variables

%%
%input parameters
%comment and uncomment to change the initialising values
source = NamedConst.audiofile;
%source = NamedConst.linein;
audiofile = 'sounds\automatic(modem)dialling\dtmfA2.wav'; %name of audiofile
Fs  = 8000;       % Sampling frequency 8 kHz

%%
%setting all DTMF and Goertzel parameters
lfg = [697 770 852 941]; % Low frequency group
hfg = [1209 1336 1477];  % High frequency group

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


disp('initialised')
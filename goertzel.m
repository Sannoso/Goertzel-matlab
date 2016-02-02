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
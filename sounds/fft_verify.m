clear all;

% Read in the sound data
[sounddata,Fsound] = audioread('tone_1.wav');
Fs  = 8000;       % Sampling frequency 8 kHz

if Fsound == Fs
    disp('The soundinput has the correct sampling frequency')
else
    disp('The soundinput does not match the 8KHz sampling frequency')
    disp('Therefor the script is aborted')
    return
end

ydft = fft(sounddata, 8000);
stem(ydft)
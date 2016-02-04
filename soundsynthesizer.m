%synthesyze sounds to analyse with the goertzel algorithm.
clear all;

symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};
[tones, Fs, f, lfg, hfg] = helperDTMFToneGenerator(symbol, false);
%tones = tones/2; %scale all vectors to have min and max -1 ;+1

%%{
%debug
stem(tones(:,1))
pause
%}

audiowrite('tone_1.wav',tones(:,1),8000);
[sounddata,Fsound] = audioread('tone_1.wav');

stem(sounddata)

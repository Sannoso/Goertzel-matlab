%synthesyze sounds to analyse with the goertzel algorithm.
clear all;

symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};
[tones, Fs, f, lfg, hfg] = helperDTMFToneGenerator(symbol, false);
tones = tones(1:320,:); %the tone is 40ms = 320 samples at minimum, so truncate
tones = tones/2; %scale all vectors to have min and max -1 ;+1

%{
%debug
stem(tones(:,1))
pause
%}

for toneChoice=1:12,
    % Select tone
    tone=tones(:,toneChoice);
    filename = strcat('tone_',num2str(toneChoice),'.wav');
    audiowrite(filename, tone, 8000);
    %{
    %debug
    filename
    [sounddata, Fsound] = audioread(filename);
    stem(sounddata)
    pause
    %}
end



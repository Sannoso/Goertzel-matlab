%Matlab code analyzing sound for Dual Tone Multi Frequency (DTMF) tones.
%I have reused a large part of this matlab code: http://nl.mathworks.com/help/signal/examples/dft-estimation-with-the-goertzel-algorithm.html
%
%Soundfile dtmfA1.wav downloaded from: http://www.ee.columbia.edu/~dpwe/sounds/dtmf/
%http://www.ee.columbia.edu/~dpwe/sounds/dtmf/dtmfA1.wav
%more soundfiles:
%http://www.ee.columbia.edu/~dpwe/sounds/
%

clear all;

%%
% Read in the sound data
for toneChoice=1:12,
    filename = strcat('sounds\tone_',num2str(toneChoice),'.wav');

    [sounddata(:,toneChoice),Fsound] = audioread(filename);


    Fs  = 8000;       % Sampling frequency 8 kHz
    disp(strcat('Soundinput :', filename))
    if Fsound == Fs
        disp(' has the correct sampling frequency')
    else
        disp(' does not match the 8KHz sampling frequency')
        disp('Therefor the script is aborted')
        return
    end

end

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

%%
%doing frequency analysis on input
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

for inputChoice=1:12,
    %goertzel analysis on each tone
    dft_data(:,inputChoice) = goertzel(sounddata(1:205,inputChoice), k+1); % Goertzel use 1-based indexing
    
    %plotting all of them
    subplot(4,3, inputChoice), stem(original_frequencies, abs(dft_data(:,inputChoice)));
    %title(['Symbol "', inputChoice,'": [',num2str(f(1,inputChoice)),',',num2str(f(2,inputChoice)),']'])
    
    %layout of plot
    ax = gca; %handle to the current axes
    ax.XTick = original_frequencies;
    xlabel('Frequency (Hz)')
    title(strcat('DFT Magnitudes tone nr: ', num2str(inputChoice)))

end

%%
%categorization of DFT data to a symbol

% Generate 12 frequency pairs
frequencypairs   = [1,1,1,2,2,2,3,3,3,4,4,4;5,6,7,5,6,7,5,6,7,5,6,7];
symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};

%check for existing frequencies
dft_threshold = 40;
categorization = zeros(7,12);
for i=1:7
    for j = 1:12
        if(abs(dft_data(i,j)) > dft_threshold)
            categorization(i,j) = 1; % frequency is present
        end
    end
end

%%{
temp = zeros(2,12);
for j=1:12
    counter = 0;
    for i=1:7
        if(categorization(i,j)==1)
            counter = counter +1;
            if(counter >2) %check wether there are more then two frequencies present
                disp(strcat('too many frequencies present in signal : ',num2str(j)))
            else
                temp(counter,j) = i;
            end
        end
    end
    for a=1:12
        if(temp(:,j) == frequencypairs(:,a))
            disp(strcat('sounds nr: ', num2str(j), ' is the DTMF sound of the symbol :"', symbol(a),'" '))
        end
    end
end
 %}           
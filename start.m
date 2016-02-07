%%
%Matlab code analyzing sound for Dual Tone Multi Frequency (DTMF) tones.
%I have reused a large part of this matlab code: 
%  http://nl.mathworks.com/help/signal/examples/dft-estimation-with-the-goertzel-algorithm.html
%
%Soundfile dtmfA1.wav downloaded from: http://www.ee.columbia.edu/~dpwe/sounds/dtmf/
%http://www.ee.columbia.edu/~dpwe/sounds/dtmf/dtmfA1.wav
%more soundfiles:
%http://www.ee.columbia.edu/~dpwe/sounds/
%
clear all;
init;
read_Audio;
audio_Slicer;

%{
for i=1:length(slices) %pass all slices into the dtmf Goertzel algorithm
    dtmf_Goertzel(sounddata(slices(i,1):slices(i,1)+Nsamples));
end
%}



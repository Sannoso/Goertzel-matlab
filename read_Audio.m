if(source == NamedConst.audiofile)
    %to-do write audiofile code
    disp('soundinput is an audiofile:')
    
    [sounddata,Fsound] = audioread(audiofile);
    disp(audiofile)
    if Fsound == Fs
        disp('audiofile has the correct sampling frequency')
    else
        disp(' does not match the 8KHz sampling frequency')
        disp('Therefor the script is aborted')
    return
    
    %Scale the sounds to -1 and 1
    %to-do: write a piece of code such that soft sounds will get results
    %aswel.
end
    
elseif(source == NamedConst.linein)
    disp('soundinput is live linein sound')
    %TO-DO write code for linein sound
    
    
else
    disp('unknown soundinput. Quitting')
    return
end

disp('audio has been read')
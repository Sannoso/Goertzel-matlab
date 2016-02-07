%slice audio in parts with length of 205 samples after every 100 samples
audiosize = length(sounddata);

amountofslices = ceil((audiosize-Nsamples)/NamedConst.windowlength) +1; 
%ceil function to have a new slice for the remainder of the division
%+1 because of the first slice has to begin at sounddata(1)

for i=1:(amountofslices -1)
    slices(i,1) = 1+((i-1)*100);
end

slices(amountofslices,1) = audiosize-Nsamples;

disp('audio has been sliced')


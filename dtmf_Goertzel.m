%%
%doing frequency analysis on input
dft_data = zeros(7,length(slices));
for i=1:length(slices)
    dft_data(:,i) = goertzel(sounddata(slices(i,1):slices(i,1)+Nsamples), k+1); % Goertzel use 1-based indexing
end
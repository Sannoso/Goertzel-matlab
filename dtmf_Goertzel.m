%%
%doing frequency analysis on input
dft_data = zeros(7,amountofslices);
for i=1:amountofslices
    dft_data(:,i) = goertzel(sounddata(slices(i,1):slices(i,1)+Nsamples), k+1); % Goertzel use 1-based indexing
end

disp('Goertzel has been performed on all slices')

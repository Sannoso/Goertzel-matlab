%categorization of DFT data to a symbol

% Generate 12 frequency pairs
frequencypairs   = [1,1,1,2,2,2,3,3,3,4,4,4;5,6,7,5,6,7,5,6,7,5,6,7];
symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};

%check for existing frequencies
classification = zeros(7,amountofslices);
for i=1:7
    for j = 1:amountofslices
        if(abs(dft_data(i,j)) > NamedConst.dft_threshold)
            classification(i,j) = 1; % frequency is present
        end
    end
end

disp('categorization done')
tempresults = zeros(2,amountofslices);
resultcounter = 0;
result = zeros(1,2);
for j=1:amountofslices
    freqcounter = 0;
    for i=1:7
        if(classification(i,j)==1)
            freqcounter = freqcounter +1;
            if(freqcounter >2) %check wether there are more then two frequencies present
                disp(strcat('too many frequencies present in audioslice : ',num2str(j)))
            else
                tempresults(freqcounter,j) = i;
            end
        end
    end
    %%{
    if(freqcounter ==2)
        resultcounter = resultcounter +1;
        for a=1:12
            if(tempresults(:,j) == frequencypairs(:,a))
                result(resultcounter,1) = j;
                result(resultcounter,2) = a;
                disp(strcat('audioslice nr: ', num2str(j), ' contains the DTMF frequencies of the symbol :"', symbol(a),'" '));
            end
        end
    end
    %}
end
disp('done with showing results')
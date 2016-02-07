temp = zeros(2,amountofslices);
for j=1:amountofslices
    counter = 0;
    for i=1:7
        if(classification(i,j)==1)
            counter = counter +1;
            if(counter >2) %check wether there are more then two frequencies present
                disp(strcat('too many frequencies present in audioslice : ',num2str(j)))
            else
                temp(counter,j) = i;
            end
        end
    end
    %%{
    if(counter ==2)
        for a=1:12
            if(temp(:,j) == frequencypairs(:,a))
                disp(strcat('audioslice nr: ', num2str(j), ' contains the DTMF frequencies of the symbol :"', symbol(a),'" '));
            end
        end
    end
    %}
end

temp = zeros(2,7);
for j=1:amountofslices
    counter = 0;
    for i=1:7
        if(classification(i,j)==1)
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
            disp(strcat('sounds nr: ', num2str(j), ' is the DTMF sound of the symbol :"', symbol(j),'" '))
        end
    end
end

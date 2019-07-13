function [result] = get_j_file_string(j)
result = '-';
for i=1:length(j)
    if i~=1
       result = [result,'-']; 
    end
    result = [result,'j',num2str(i),'-',num2str(j(i))];
end
end

function [result] = get_j_display_string(j)
result = '';
for i=1:1:length(j)
    result = [result,' $j_',num2str(i),'=',num2str(j(i)),'$'];
end
end


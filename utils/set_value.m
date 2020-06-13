function [structure] =  set_value(structure, field_name, value)
if size(value) == 1
    eval(['structure.',field_name,'=',num2str(value),';']);
else
    eval(['structure.',field_name,'=[',num2str(value),'];']);
end

end

function [result] = check_property_exists(params, property_name)

result=false;
field_names = fieldnames(params);

for i=1:1:length(field_names)
    if strcmp(field_names{i}, property_name)
        result = true;
        return;
    end
    
end

end


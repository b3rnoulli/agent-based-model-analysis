function [result] = check_property_exists(params, property_name)
result=false;

if isempty(params)
   return; 
end
field_names = fieldnames(params);

for i=1:1:length(field_names)
    if strcmp(field_names{i}, property_name)
        result = true;
        return;
    end
    
end

end


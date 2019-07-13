function [missing_file_names] = check_file_exists(file_path_resolver, file_name_resolver, params)
missing_file_names = {};
missing_file_counter = 1;
for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    try 
        load([file_path, file_name,'.mat']); 
    catch
        missing_file_names{missing_file_counter} = file_name;
        missing_file_counter=missing_file_counter+1;
    end
           
end

end


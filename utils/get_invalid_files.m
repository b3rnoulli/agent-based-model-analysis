function [missing_file_names, missing_mfdfa_data_names, missing_returns_names] = get_invalid_files(file_path_resolver, file_name_resolver, params)
missing_file_names = {};
missing_file_counter = 1;

missing_mfdfa_data_names = {};
missing_mfdfa_data_counter = 1;

missing_returns_names = {};
missing_returns_counter=1;

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    try 
        data = load([file_path, file_name,'.mat']); 
        
        if ~check_property_exists(data,'MFDFA2')
            missing_mfdfa_data_names{missing_mfdfa_data_counter} = file_name;
            missing_mfdfa_data_counter=missing_mfdfa_data_counter+1;
        end
        
        if ~check_property_exists(data,'returns')
            missing_returns_names{missing_returns_counter} = missing_returns_names;
            missing_returns_counter=missing_returns_counter+1;
        end
        
    catch
        missing_file_names{missing_file_counter} = file_name;
        missing_file_counter=missing_file_counter+1;
    end
           
end

end


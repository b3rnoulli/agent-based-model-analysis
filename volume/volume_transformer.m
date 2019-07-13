function [data] = volume_transformer(file_path_resolver, file_name_resolver, params)


for iterator=1:1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    fprintf('[volume_transformer] Transforming volume for result file %s \n', file_name);
    data = load([file_path, file_name,'.mat']);
    
    if check_property_exists(data, 'volume') && check_property_exists(data.volume, 'total')
        fprintf('[volume transformer] Result file %s has been already transformed', file_name);
    end
    validate_property_exists(data, 'transaction_volume');
    
    if isstruct(data.transaction_volume)
        data.volume = data.transaction_volume;
    else
        
        data.volume.total = data.transaction_volume;
        
        if check_property_exists(data,'transaction_negative_volume')
            data.volume.negative =  data.transaction_negative_volume;
            data = rmfield(data, 'transaction_negative_volume');
        end
        
        if check_property_exists(data,'transaction_positive_volume')
            data.volume.positive =  data.transaction_positive_volume;
            data=rmfield(data, 'transaction_positive_volume');
        end
    end
    data = rmfield(data, 'transaction_volume');
    save([file_path, file_name,'.mat'],'-struct','data');
    
end

end


function calculate_returns(file_path_resolver, file_name_resolver, params)

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    data = load([file_path, file_name,'.mat']);  
  
    if check_property_exists(data, 'mag_raw')
        price_used_in_calculations = data.mag_raw;
    else
        price_used_in_calculations = data.mag;
        data.mag_raw = data.mag;
    end
        
    range = resolve_calculation_range(param_array, price_used_in_calculations);
    fprintf('[calculate_returns] Calculating returns for file %s in range %s-%s \n', file_name, num2str(range(1)), num2str(range(2)));
    price_used_in_calculations_temp = zeros(range(2)-range(1), size(price_used_in_calculations,2));
    for i=1:size(price_used_in_calculations,2)
       price_used_in_calculations_temp(:,i) = price_used_in_calculations(range(1)+1:range(2),i);
    end
    price_used_in_calculations = price_used_in_calculations_temp;
    
    data.returns = zscore(diff(price_used_in_calculations));
    data.mag = price_used_in_calculations;
    save([file_path, file_name,'.mat'],'-struct','data');
end

end

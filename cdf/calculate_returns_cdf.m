function [result] = calculate_returns_cdf(file_path_resolver, file_name_resolver, params)


number_of_bins = 101;
range = [0.1 50];

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    fprintf('[calculate_returns_cdf] Calculating cdf for file %s \n',file_name);
    data = load([file_path, file_name,'.mat']);
    
    validate_property_exists(data, 'returns');
    
    for i=1:size(data.returns,2)
        [result.x(i,:), result.F(i,:)] = cdf(abs(data.returns(:,i)), range, number_of_bins);
    end
    
    save([file_path, file_name,'-cdf.mat'],'-struct','result');
end

end


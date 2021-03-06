function [result] = calculate_volume_mean_cdf(file_path_resolver, file_name_resolver, params, save_single_results)

if ~exist('save_single_results','var')
    save_single_results = false;
end

number_of_bins = 101;
range = [0.1 14400];
result.x=exp(linspace(log(range(1)),log(range(2)),number_of_bins));
result.F = zeros(length(params), length(result.x)-1);

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    fprintf('[calculate_mean_cdf] Calculating mean cdf for file %s \n',file_name);
    data = load([file_path, file_name,'-',num2str(param_array.execution),'.mat']);
    
    validate_property_exists(data, 'returns');
    
    [result.x, result.F(iterator,:)] = cdf(abs(data.volume.total), range, number_of_bins);
    
    if save_single_results
        single_result.x = result.x;
        single_result.F = result.F(iterator,:);
        save([file_path, file_name,'-',num2str(param_array.execution),'-volume-cdf.mat'],'-struct','single_result');
    end
    
end

result.F = mean(result.F);
save([file_path_resolver(params(1)), file_name_resolver(params(1)),'-mean-volume-cdf.mat'],'-struct','result');

end

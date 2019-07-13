function [result] = calculate_mean_autocorrelation(file_path_resolver, file_name_resolver, params, save_single_results)

if ~exist('save_single_results','var')
    save_single_results = false;
end

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    fprintf('[calculate_mean_autocorrelation] Calculating mean acf for file %s \n',file_name);
    
    data = load([file_path, file_name,'-',num2str(param_array.execution),'.mat']);
    
    validate_property_exists(data, 'returns');
    
    range = resolve_calculation_range(param_array, data.returns);
    
    returns_used_in_calculation = data.returns(range(1):range(2));
    
    volatility_acf = autocorr(abs(returns_used_in_calculation),length(returns_used_in_calculation)-1);
    returns_acf =  autocorr((returns_used_in_calculation),length(returns_used_in_calculation)-1);
    
    if save_single_results
        volatility = volatility_acf;
        returns = returns_acf;
        save([file_path, file_name,'-',num2str(param_array.execution),'-acf.mat'],'volatility','returns')
    end
    
    mean_volatility_acf(iterator,:) = volatility_acf;
    mean_returns_acf(iterator,:) = returns_acf;
    
end

result.volatility=mean(mean_volatility_acf);
result.returns=mean(mean_returns_acf);
result.volatility_std=std(mean_volatility_acf);
result.returns_std = std(mean_returns_acf);

save([file_path_resolver(params(1)), file_name_resolver(params(1)),'-mean-acf.mat'],'-struct','result');

end


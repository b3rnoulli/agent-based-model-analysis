function [result] = calculate_cross_correlation(file_path_resolver, file_name_resolver, params)

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution')
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    fprintf('[calculate_cross_correlation] Calculating cross correlation for file %s \n',file_name);
    
    data = load([file_path, file_name,'.mat']);
    
    validate_property_exists(data, 'returns');
    
    range = resolve_calculation_range(param_array, data.returns);
    
    returns_used_in_calculation = data.returns(range(1):range(2),:);
    volume_used_in_calculation = data.transaction_volume.total(end-length(returns_used_in_calculation):end,:);
    
    [result.returns_xcorr,~,~] = crosscorr((returns_used_in_calculation(:,1)),(returns_used_in_calculation(:,2)),'NumLags',length(returns_used_in_calculation(:,1))-1);
    result.returns_xcorr(1:(floor(length(result.returns_xcorr)/2)-1)) = [];
     
    [result.volatility_xcorr,lags,bounds] = crosscorr(abs(returns_used_in_calculation(:,1)),abs(returns_used_in_calculation(:,2)),'NumLags',length(returns_used_in_calculation(:,1))-1);
    result.volatility_xcorr(1:(floor(length(result.volatility_xcorr)/2)-1)) = [];
    
    [result.volume_xcorr,~,~] = crosscorr(abs(volume_used_in_calculation(:,1)),abs(volume_used_in_calculation(:,2)),'NumLags',length(volume_used_in_calculation(:,1))-1);
    result.volume_xcorr(1:(floor(length(result.volume_xcorr)/2)-1)) = [];
    
    save([file_path, file_name,'-xcorr.mat'],'-struct','result');
    
end



end


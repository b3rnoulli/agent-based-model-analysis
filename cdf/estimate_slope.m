function [estimated_slope_params] = estimate_slope(file_path_resolver, file_name_resolver, params, estimation_range)

file_name = file_name_resolver(params);
file_path = file_path_resolver(params);
data = load([file_path, file_name,'-',num2str(params.execution),'-cdf.mat']);

estimated_slope_params = fit_power_law(data.x, data.F, estimation_range);

estimation_space = estimation_range(1):0.1:estimation_range(2);
loglog(estimation_space, abs(estimated_slope_params(2)).*(estimation_space.^(estimated_slope_params(1))),...
    'DisplayName',['$x^{',num2str(estimated_slope_params(1)),'}$'],'LineWidth',3);

end


function [f] = plot_cdf(f, file_path_resolver, file_name_resolver, display_name_resolver, params, plot_properties, reference_params)

if ~exist('plot_properties','var') || isempty(plot_properties)
    plot_properties = get_default_plot_properties();
end

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution');
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    data = load([file_path, file_name,'-cdf.mat']);
    loglog(data.x(1,:),1-data.F(1,:),'LineWidth',plot_properties.line_width,'color',plot_properties.colors{iterator},'Marker',plot_properties.markers{iterator},...
        'DisplayName',display_name_resolver(param_array), 'MarkerSize', plot_properties.marker_size,'MarkerFaceColor', plot_properties.colors{iterator});
    hold on;
end

if exist('reference_params','var')
    
    if ~check_property_exists(reference_params, 'multiplier')
        reference_params.multiplier = 1;
    end
    
    plot(reference_params.x_range, reference_params.multiplier.*(reference_params.x_range.^-3),'-k','DisplayName','$x^{-3}$');
    
    random_values = randn([1 1000000]);
    [y_rand,x_rand] = ecdf(abs(random_values));
    loglog(x_rand, 1-y_rand,'--k','DisplayName','$N(0,1)$')
    
end

set_default_plot_properties(gca);
xlim([0.2,100]);
ylim([10^-6,1]);
xlabel('$|r(t)|$')
ylabel('$F(|r(t)|)$');
legend show
title('1-CDF')
end

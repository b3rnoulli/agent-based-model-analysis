function [f]=plot_returns_cross_correlation(f, file_path_resolver, file_name_resolver, display_name_resolver, params)

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution');
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    data = load([file_path, file_name,'-xcorr.mat']);
    
    loglog(abs(data.returns_xcorr),'LineWidth',2,'DisplayName',display_name_resolver(param_array));
    hold on;
end

xlim([1 length(data.returns_xcorr)+2000]);
ylim([10^-5 1]);
set_default_plot_properties(gca);

xlabel('$\tau$','Interpreter','latex');
ylabel('$\rho_{r^{1}(t)r^{2}(t)}(\tau)$','Interpreter','latex');

end

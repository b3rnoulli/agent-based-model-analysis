function [f]=plot_autocorrelation(f, file_path_resolver, file_name_resolver, display_name_resolver, params, save_plot)

if ~exist('save_plot','var')
    save_plot = false;
end

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution');
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    acf = load([file_path, file_name,'-acf.mat']);
    
    validate_property_exists(acf, 'volatility');
    loglog(acf.volatility,'LineWidth',2,'DisplayName',display_name_resolver(param_array));
    hold on;
end

xlim([1 length(acf.volatility)+2000]);
ylim([10^-5 1]);
set_default_plot_properties(gca);

xlabel('$\tau$','Interpreter','latex');
ylabel('$C_{\tau}(|r(t)|)$','Interpreter','latex');
title('Volatility autocorrelation');

if save_plot
    saveas([file_path, file_name,'-',num2str(param_array.execution),'-acf.png'],'png');
    saveas([file_path, file_name,'-',num2str(param_array.execution),'-acf.png'],'fig');
end

end

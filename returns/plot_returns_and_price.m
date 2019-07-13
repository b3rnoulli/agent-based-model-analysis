function plot_returns_and_price(file_path_resolver, file_name_resolver, display_name_resolver, params, save_plot, price_range, returns_range)

if ~exist('save_plot','var')
    save_plot = false;
end

if ~exist('price_range','var')
    price_range = [-0.15 0.15];
end

if ~exist('returns_range','var')
    returns_range = [-30 30];
end

f = figure('units','normalized','position',[.05 .05 .55 .75]);

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution');
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    data = load([file_path, file_name,'.mat']);
    
    validate_property_exists(data, 'returns');
    validate_property_exists(data, 'mag');
    
    subplot(2,1,1)
    title('Magnetization and returns')
    plot_price(data.mag, display_name_resolver(params(iterator)));
    ylim(price_range);
    
    subplot(2,1,2)
    plot_returns(data.returns, display_name_resolver(params(iterator)));
    ylim(returns_range);
    
    if save_plot
        saveas(f,[file_path, file_name,'-price-returns.png'],'png');
        saveas(f,[file_path, file_name,'-price-returns.fig'],'fig');
    end
end



end


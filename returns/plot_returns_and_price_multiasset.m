function plot_returns_and_price_multiasset(file_path_resolver, file_name_resolver, display_name_resolver, params, save_plot, price_range, returns_range)

if ~exist('save_plot','var')
    save_plot = false;
end

if ~exist('price_range','var')
    price_range = [-0.15 0.15];
end

if ~exist('returns_range','var')
    returns_range = [-30 30];
end

plot_properties = get_default_plot_properties();

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
    for i=1:size(data.mag,2)
        plot_price(data.mag(:,i), display_name_resolver(params(iterator),i), plot_properties.colors{i});
        hold on;
    end
    ylim(price_range);
    hold off;
    
    subplot(2,1,2)
    for i=1:size(data.returns,2)
        plot_returns(data.returns(:,i), display_name_resolver(params(iterator), i), plot_properties.colors{i});
        hold on;
    end
    hold off
    ylim(returns_range);
    
    if save_plot
        saveas(f,[file_path, file_name,'-price-returns.png'],'png');
        saveas(f,[file_path, file_name,'-price-returns.fig'],'fig');
    end
end



end


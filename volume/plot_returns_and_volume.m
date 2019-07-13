function plot_returns_and_volume(file_path_resolver, file_name_resolver, display_name_resolver, params, save_plot, returns_range, volume_y_range, volume_x_range, ...
    plot_negative_and_positive_volume)

if ~exist('save_plot','var')
    save_plot = false;
end

if ~exist('volume_range','var')
    volume_y_range = [0 14400];
end

if ~exist('volume_range','var')
    volume_x_range = [50000 300000];
end

if ~exist('returns_range','var')
    returns_range = [-30 30];
end

if ~exist('plot_negative_and_positive_volume', 'var')
    plot_negative_and_positive_volume = false;
end

f = figure('units','normalized','position',[.05 .05 .55 .75]);

plot_properties = get_default_plot_properties();

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution');
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    data = load([file_path, file_name,'.mat']);
    
    validate_property_exists(data, 'returns');
    validate_property_exists(data, 'volume');
    
    subplot(2,1,1)
    for i=1:size(data.returns,2)
        plot_returns(data.returns(:,i), display_name_resolver(params(iterator),i), plot_properties.colors{i});
        hold on;
    end
    hold off;
    ylim(returns_range);
    
    subplot(2,1,2)
    for i=1:size(data.volume.total,2)
        volume_time_range = volume_x_range;
        plot_volume(data.volume, display_name_resolver(params(iterator)), plot_negative_and_positive_volume, volume_time_range, plot_properties.colors{i}, i);
        hold on;
    end
    ylim(volume_y_range);
    xlim([1 volume_x_range(2)-volume_x_range(1)]);
    hold off;
    
    
    if save_plot
        saveas(f,[file_path, file_name,'-',num2str(param_array.execution),'-volume-returns.png'],'png');
        saveas(f,[file_path, file_name,'-',num2str(param_array.execution),'-volume-returns.fig'],'fig');
    end
end



end


function plot_volume_and_non_active_agents(file_path_resolver, file_name_resolver, display_name_resolver, params, save_plot, non_active_agents_range,...
volume_range)

if ~exist('non_active_agents_range','var')
    non_active_agents_range = [0 14400];
end

if ~exist('volume_range','var')
    volume_range = [0 14400];
end

f = figure('units','normalized','position',[.05 .05 .55 .75]);

for iterator=1:length(params)
    param_array = params(iterator);
    validate_property_exists(param_array, 'execution');
    
    file_name = file_name_resolver(param_array);
    file_path = file_path_resolver(param_array);
    
    data = load([file_path, file_name,'.mat']);
    
    validate_property_exists(data, 'returns');
    validate_property_exists(data, 'volume');
    
    subplot(2,1,1)
    time_range = [length(data.volume.total) - length(data.returns), length(data.volume.total)];
    plot_volume(data.volume, display_name_resolver(params(iterator)), false, time_range);
    ylim(volume_range);
    title('Volume and non active state agents')
    
    subplot(2,1,2)
    plot(data.zero_state_agents(time_range(1):time_range(2)),'k', 'DisplayName', display_name_resolver(param_array));
    set_default_plot_properties(gca);
    ylabel('$N_{0}(t)$','Interpreter','latex');
    xlabel('t','Interpreter','latex');
    ylim(non_active_agents_range);
    
    if save_plot
        saveas(f,[file_path, file_name,'-volume-zero-agents-',num2str(non_active_agents_range(1)),'-',num2str(non_active_agents_range(2)),'.png'],'png');
        saveas(f,[file_path, file_name,'-volume-zero-agents-',num2str(non_active_agents_range(1)),'-',num2str(non_active_agents_range(2)),'.fig'],'fig');
    end
end

end

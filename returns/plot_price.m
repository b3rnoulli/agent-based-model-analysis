function plot_price(price, display_name, color)

if ~exist('color','var')
    color = [0 0 0];
end
plot(price,'Color',color,'DisplayName',display_name);

set_default_plot_properties(gca);
ylabel('P(t)','Interpreter','latex');
xlabel('t','Interpreter','latex');

end


index=1;
plot(MFDFA2.alfa(bottom:70), MFDFA2.f(bottom:70),'color',plot_properties.colors{index},'Marker',plot_properties.markers{index},...
            'DisplayName',['asd+',num2str(index)],'LineWidth', plot_properties.line_width, 'MarkerSize', plot_properties.marker_size);
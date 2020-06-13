function plot_price(price, display_name, color)

if ~exist('color','var')
    color = [0 0 0];
end
plot(price,'Color',color,'DisplayName',display_name);

set_default_plot_properties(gca);
ylabel('P(t)','Interpreter','latex');
xlabel('t','Interpreter','latex');

end

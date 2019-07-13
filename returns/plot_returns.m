function plot_returns(returns, display_name, color)

if ~exist('color','var')
    color = [0 0 0];
end

plot(returns,'Color',color,'DisplayName',display_name);

set_default_plot_properties(gca);
ylabel('r(t)','Interpreter','latex');
xlabel('t','Interpreter','latex');

end


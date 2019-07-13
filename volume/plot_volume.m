function plot_volume(volume, display_name, plot_negative_and_positive_volume, range, color, instrument)
if ~exist('color','var')
    color = [0 0 0];
end

if ~exist('plot_negative_and_positive_volume','var')
    plot_negative_and_positive_volume = false;
end

if ~exist('range', 'var')
   range = [1 length(volume.total)]; 
end

if ~exist('instrument', 'var')
   instrument = 1;
end

validate_property_exists(volume,'total');

plot(volume.total(range(1):range(2),instrument),'Color',color,'DisplayName',display_name);

if plot_negative_and_positive_volume
    hold on;
    plot(volume.negative(range(1):range(2),instrument),'r','DisplayName',display_name);
    plot(volume.positive(range(1):range(2),instrument),'g','DisplayName',display_name);
end

set_default_plot_properties(gca);
ylabel('V(t)','Interpreter','latex');
xlabel('t','Interpreter','latex');
end

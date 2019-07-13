function adjust_legend_position(location)
legend_handle = findobj(gcf, 'Type', 'Legend');
legend_handle.Location = location;
end


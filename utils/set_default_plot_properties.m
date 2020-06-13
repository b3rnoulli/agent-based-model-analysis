function set_default_plot_properties(ax)

ax.FontSize = 28;
ax.FontName = 'Times';
ax.Box = 'on';
ax.LineWidth = 1.5;
legend show
ax.Legend.Interpreter='latex';
ax.Legend.FontSize = 28;
ax.XAxis.TickLength = [0.015 1];
ax.YAxis.TickLength = [0.015 1];
end


function [fitted, x_limited, y_limited, gof] = fit_power_law(x, y, range)

if length(range) ~= 2
    throw(MException('[cdf_fit:001]','Range of fit not specified'))
end

x_limited = x(x>range(1));
y_limited = y(end-length(x_limited)+1:end);

x_limited(x_limited>range(2)) = [];
y_limited = y_limited(1:length(x_limited));

opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Robust = 'Bisquare';


[fitted, gof] = fit(log(x_limited)', log(1-y_limited)',fittype('poly1'), opts);

fitted_values = fitted.p2.*(x_limited.^fitted.p1);

% [fitted, gof] = polyfit(log(x_limited), log(1-y_limited),1);

% fitted_values = polyval(fitted, log(x_limited));

end
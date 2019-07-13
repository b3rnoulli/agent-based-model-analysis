function [x, values] = cdf(data, range, bins)

space = exp(linspace(log(range(1)),log(range(2)),bins));
[n, edges] = histcounts(data, space);

n = n ./ sum(n);

values = cumsum(n);
x = edges(2:end);

end


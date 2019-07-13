function [result] = resolve_multiple_param_string(values)
if ischar(values)
    values = strsplit(values,' ');
end

if (ischar(values) || isnumeric(values)) && length(values) == 1
    result = num2str(values);
elseif iscell(values) && length(values) == 1
    result = num2str(values{1});
else
    result = [num2str(values{1}),'-',num2str(values{end})];
end
end
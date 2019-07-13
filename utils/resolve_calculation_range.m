function [range] = resolve_calculation_range(params,data)

range = [1 length(data)];

if check_property_exists(params,'range')
   range = params.range;
end

end


function [result] = takaishi_display_name_resolver(params)
result = 'Takaishi';

if check_property_exists(params,'beta')
    result = [result,' $\beta$= ',num2str(params.beta)];
end

if check_property_exists(params,'alpha')
    result = [result,' $\alpha$= ',num2str(params.alpha)];
end

if check_property_exists(params,'j')
    result = [result,get_j_display_string(params.j)];
end

if check_property_exists(params,'kappa')
   result = [result,' $\kappa$=',num2str(params.kappa)]; 
end

end


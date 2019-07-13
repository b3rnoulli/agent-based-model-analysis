function [file_name] = takaishi_file_name_resolver(params)
file_name = 'takaishi';

if check_property_exists(params,'beta')
    file_name = [file_name,'-beta-',num2str(params.beta)];
end

if check_property_exists(params,'alpha')
    file_name = [file_name,'-alpha-',num2str(params.alpha)];
end

if check_property_exists(params,'j')
    file_name = [file_name,get_j_file_string(params.j)];
end

end




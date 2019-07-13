function [file_path] = takaishi_file_path_resolver(params)

if ~check_property_exists(params,'datasource')
    params.datasource='DEFAULT';
end

root_path = [get_root_data_path(params.datasource),'takaishi-results/'];
suffix='';

if check_property_exists(params,'beta')
    suffix=[suffix,num2str(params.beta)];
end

if check_property_exists(params,'j')
    suffix = [suffix, get_j_path_string(params.j)];
end

if check_property_exists(params,'surrogate') && params.surrogate==true
   suffix=[suffix,'/surrogates']; 
end

file_path = [root_path, suffix,'/'];

end

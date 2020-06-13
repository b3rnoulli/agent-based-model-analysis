function [params] = build_multi_params(constant_values, constant_field_names, field_name, field_values, params)

fprintf('[build_multi_params] Build multi execution params for constat field names: [%s], changing field name: [%s] \n',...
    strjoin(constant_field_names),  field_name);

if length(constant_values) ~= length(constant_field_names)
    throw(MException('build_multi_params:values_field_size_error','Values and field names are not the same size'));
end

values_struct = cell2struct(constant_values', constant_field_names);
values_struct = append_empty_field(values_struct, field_name);

if ~exist('params', 'var')
  params = struct;
end

params_index = get_starting_index(params);

if params_index == 1
   params = values_struct; 
end

for i=1:length(field_values)
    values_struct = append_field(values_struct, field_name, field_values{i});
    params(params_index) = values_struct;
    params_index = params_index +1;
end

fprintf('[build_multi_params] Built params \n');
display(struct2table(params));

end


function [index] = get_starting_index(params)
if is_empty_structure(params)
    index = 1;
    return;
end
index = length(params)+1;
end

function [values_struct] = append_field(values_struct, field_name, field_value)
eval(['values_struct.',field_name,'=''',num2str(field_value),''';']);
end

function [values_struct] = append_empty_field(values_struct, field_name)
eval(['values_struct.',field_name,'=[];']);
end

function [result] = is_empty_structure(params)
result = false;

if length(params) == 1 && isempty(fieldnames(params))
   result = true; 
end

end
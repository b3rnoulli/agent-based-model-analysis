function  validate_property_exists(params, property_name)

property_exists = check_property_exists(params,property_name);

if ~property_exists
    exception_message = 'Property %s does not exists in given structure. Found properties: [%s]';
    throw(MException('validate_property_exists:property_not_exist',exception_message, property_name, strjoin(fieldnames(params))));
end

end


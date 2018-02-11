# require_relative 'blueprint'
# require_relative 'skill'


require_relative 'SDE/inv_type'
require_relative 'SDE/industry_blueprint'
require_relative 'SDE/industry_activity_material'
require_relative 'SDE/industry_activity_products'

DataMapper.repository(:default).adapter.field_naming_convention = lambda do |property|
  "#{property.name.to_s.camelize}"
end

DataMapper.repository(:default).adapter.resource_naming_convention = lambda do |name|
  "#{name.to_s.camelize(:lower).pluralize}"
end



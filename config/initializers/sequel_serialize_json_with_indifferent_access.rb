require 'sequel/plugins/serialization'
Sequel::Plugins::Serialization.register_format(
  :json_with_indifferent_access,
  ->(v) { Sequel.object_to_json(v) },
  ->(v) { Sequel.parse_json(v).with_indifferent_access }
)

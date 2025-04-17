# config/initializers/fix_enum_patch.rb
ActiveSupport.on_load(:active_record) do
    include ActiveRecord::Enum unless self.method_defined?(:enum)
  end
  
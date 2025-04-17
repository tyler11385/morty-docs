puts "🛠️ Running enum patch initializer..."

# 🔥 Remove any broken method globally
Class.class_eval do
  remove_method(:enum) rescue nil
end

Module.class_eval do
  remove_method(:enum) rescue nil

  def enum(*args, **kwargs)
    puts "✅ Patched enum triggered in #{self.name}"
    ActiveRecord::Enum.extended(self)
    ActiveRecord::Enum.instance_method(:enum).bind(self).call(*args, **kwargs)
  end
end

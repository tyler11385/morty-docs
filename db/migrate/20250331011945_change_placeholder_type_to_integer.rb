class ChangePlaceholderTypeToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :placeholders, :placeholder_type, :integer, using: 'placeholder_type::integer'
  end
end

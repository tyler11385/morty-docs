class AddStatusToTemplates < ActiveRecord::Migration[7.1]
  def change
    add_column :templates, :status, :integer, default: 0, null: false
  end
end

class ChangeRoleToIntegerInUsers < ActiveRecord::Migration[7.1] # or your current version
  def change
    remove_column :users, :role, :string
    add_column :users, :role, :integer, default: 0, null: false
  end
end

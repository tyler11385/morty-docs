class CreatePlaceholders < ActiveRecord::Migration[8.0]
  def change
    create_table :placeholders do |t|
      t.string :name
      t.string :placeholder_type
      t.string :format
      t.string :mapping
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end

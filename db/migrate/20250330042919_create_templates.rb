class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.text :content
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end

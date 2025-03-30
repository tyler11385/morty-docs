class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.references :template, null: false, foreign_key: true
      t.jsonb :data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddApiSupportFieldsToDocuments < ActiveRecord::Migration[7.1]
  def change
    change_table :documents do |t|
      t.jsonb :placeholders, default: {}
      t.string :external_reference
      t.string :status, default: "created"
      t.datetime :generated_at
    end
  end
end

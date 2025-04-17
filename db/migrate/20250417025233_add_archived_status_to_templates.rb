class AddArchivedStatusToTemplates < ActiveRecord::Migration[6.1]
  def change
    change_column_default :templates, :status, from: 0, to: 0

    # Optional safety measure: update any NULL statuses to draft
    Template.where(status: nil).update_all(status: 0)
  end
end

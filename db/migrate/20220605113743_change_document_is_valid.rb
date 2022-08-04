class ChangeDocumentIsValid < ActiveRecord::Migration[6.1]
  def change
    remove_column :documents, :is_valid
    add_column :documents, :status, :integer, default: 0
  end
end

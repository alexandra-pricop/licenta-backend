class DropTableDocumentUser < ActiveRecord::Migration[6.1]
  def change
    drop_table :document_users
  end
end

class AddDescriptionToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :description, :string
    add_column :documents, :issue_date, :date
  end
end

class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.belongs_to :company, null: false, foreign_key: true
      t.integer :author_id
      t.string :title
      t.integer :category
      t.boolean :is_valid, default: false

      t.timestamps
    end
  end
end

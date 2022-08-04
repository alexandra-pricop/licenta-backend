class CreateApiV1Companies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cui

      t.timestamps
    end
  end
end

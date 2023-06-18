class AddFirebaseIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firebase_id, :string
  end
end

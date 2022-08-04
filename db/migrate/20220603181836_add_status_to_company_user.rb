class AddStatusToCompanyUser < ActiveRecord::Migration[6.1]
  def change
    add_column :company_users, :status, :integer, default: 0
  end
end

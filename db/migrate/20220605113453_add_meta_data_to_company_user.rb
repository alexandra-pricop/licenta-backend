class AddMetaDataToCompanyUser < ActiveRecord::Migration[6.1]
  def change
    add_column :company_users, :meta_data, :json
  end
end

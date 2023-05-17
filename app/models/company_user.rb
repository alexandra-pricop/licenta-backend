# == Schema Information
#
# Table name: company_users
#
#  id         :bigint           not null, primary key
#  company_id :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("cerere")
#  meta_data  :json
#
class CompanyUser < ApplicationRecord
  belongs_to :company
  belongs_to :user

  enum status: [:cerere, :aprobat, :refuzat]

  validates_uniqueness_of :user, scope: :company
  
  def serialize
    {id: self.id, status: self.status, meta_data: self.meta_data, company: self.company.serialize, user: self.user.serialize }
  end

  def meta_data_categories
    categories = self.meta_data&.dig('categories') || []
    categories.map{|category| Document.categories[category.to_sym]}
  end  

end

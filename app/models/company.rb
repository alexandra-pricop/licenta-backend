# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  cui        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("cerere")
#
class Company < ApplicationRecord
    has_many :company_users, dependent: :restrict_with_error
    has_many :users, through: :company_users
    has_many :documents, dependent: :restrict_with_error

    # un contabil aproba compania
    enum status: [:cerere, :aprobat, :refuzat]
    
    validates_uniqueness_of :name, :cui

    def serialize
        self.as_json(only: [:id, :name, :cui, :status])
    end

end

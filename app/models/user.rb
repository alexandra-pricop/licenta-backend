# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  role                   :integer
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :validatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  enum role: [:admin, :contabil_sef, :contabil, :patron, :angajat]

  has_many :company_users, dependent: :destroy
  has_many :companies,  through: :company_users
  has_many :approved_companies, -> {where("company_users.status = 1")}, source: :company, through: :company_users

  validates_presence_of :name, :email, :role

  def serialize
    self.as_json(only: [:id, :name, :email, :role, :created_at, :updated_at])
  end

  def visible_companies
    case role
    when 'admin', 'contabil_sef', 'contabil'
      Company.all
    else
      self.approved_companies
    end
  end

  def company_user(company)
    self.company_users.find_by(company: company)
  end
  
end

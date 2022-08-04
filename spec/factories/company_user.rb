FactoryBot.define do
  factory :company_user do
    company { FactoryBot.create(:company)}
    user { }
  end

  factory :company_users_angajat, class: "CompanyUser" do
    company { }
    user { FactoryBot.create(:angajat) }
  end

  factory :company_users_contabil, class: "CompanyUser" do
    company { }
    user { FactoryBot.create(:contabil) }
  end
  
end
FactoryBot.define do
  factory :company do
    name { Faker::Company.unique.name }
    cui  { Faker::Company.unique.czech_organisation_number }
  end
  
  factory :company_without_cui, class: "Company" do
    name { Faker::Company.unique.name }
  end
end
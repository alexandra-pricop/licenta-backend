FactoryBot.define do
  factory :admin, class: "User" do
    name { Faker::Name.name }
    email  { Faker::Internet.unique.safe_email }
    password { '12345678'}
    role { 'admin'}
  end

  factory :contabil_sef, class: "User" do
    name { Faker::Name.name }
    email  { Faker::Internet.unique.safe_email }
    password { '12345678'}
    role { 'contabil_sef'}
  end

  factory :contabil, class: "User" do
    name { Faker::Name.name }
    email  { Faker::Internet.unique.safe_email }
    password { '12345678'}
    role { 'contabil'}
  end

  factory :patron, class: "User" do
    name { Faker::Name.name }
    email  { Faker::Internet.unique.safe_email }
    password { '12345678'}
    role { 'patron'}
  end

  factory :angajat, class: "User" do
    name { Faker::Name.name }
    email  { Faker::Internet.unique.safe_email }
    password { '12345678'}
    role { 'angajat'}
  end
end
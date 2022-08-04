FactoryBot.define do
  factory :document do
    title { Faker::Lorem.unique.sentence  }
    description  { Faker::Lorem.unique.paragraph }
    issue_date { Faker::Date.between(from: 1.month.ago, to: 2.days.ago)}
  end
end
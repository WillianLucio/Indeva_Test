FactoryBot.define do
  factory :store do
    name { FFaker::Lorem.word }
    user
  end
end

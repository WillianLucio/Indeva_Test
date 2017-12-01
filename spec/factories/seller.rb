FactoryBot.define do
  factory :seller do
    name { FFaker::Lorem.word }
    store
  end
end

FactoryBot.define do
  factory :trip do
    sequence(:name) { |n| "Trip #{n}" }
    sequence(:description) { |n| "Description #{n}" }
  end
end

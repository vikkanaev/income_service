FactoryBot.define do
  factory :operation do
    amount { 10.00 }
    description { 'op description' }
    period
    user
  end
end

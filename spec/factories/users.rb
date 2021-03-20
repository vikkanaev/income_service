FactoryBot.define do
  factory :user do
    email { generate(:email) }
    password { 'qwerty' }
  end
end

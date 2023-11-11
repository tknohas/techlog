FactoryBot.define do
  factory :user do
    nickname { 'サンジ' }
    sequence :email do |n|
      "test#{n}@test.com"
    end
    password {'111111'}
    password_confirmation { '111111' }
  end
end

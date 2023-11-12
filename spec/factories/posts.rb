FactoryBot.define do
  factory :post do
    title { '本文1' }
    content { 'コンテンツ1' }
    association :user, factory: :user
  end 
end

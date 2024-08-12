FactoryBot.define do
  factory :student do

    name { Faker::Name.name }
    cpf { Faker::CPF.pretty }

    trait :card do
      payment_method { 'credit_card' }
    end

    trait :boleto do
      payment_method { 'boleto' }
    end
  end
end

FactoryBot.define do
  factory :student do

    name { 'Student Name' }
    cpf { '476.623.748-07' }

    trait :card do
      payment_method { 'credit_card' }
    end

    trait :boleto do
      payment_method { 'boleto' }
    end
  end
end

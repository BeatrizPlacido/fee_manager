FactoryBot.define do
  factory :enrollment do
    association :student

    amount { 1200 }
    installments { 6 }
    due_day { 31 }
  end
end

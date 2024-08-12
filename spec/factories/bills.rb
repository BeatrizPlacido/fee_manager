FactoryBot.define do
  factory :bill do
    association :enrollment
    amount { 200 }
    due_date { Date.today + 30.days }

    trait :waiting do
      status { 'waiting' }
    end

    trait :pending do
      status { 'pending' }
    end

    trait :paid do
      status { 'pending' }
    end

    trait :overdue do
      due_date { Date.today - 3.days }
    end
  end
end

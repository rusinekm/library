FactoryBot.define do
  factory :user_book do
    association :user
    association :book
    borrow_time { Time.current }
    return_time { nil }
  end
end

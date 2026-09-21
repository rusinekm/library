FactoryBot.define do
  factory :book do
    association :author
    title { Faker::Book.title }
    deleted { false }

    after(:build) do |book|
      book.serial_number ||= rand(000_000..999_999) while Book.exists?(serial_number: book.serial_number)
    end
  end
end

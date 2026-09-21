FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    after(:build) do |user|
      user.library_card ||= rand(000_000..999_999) while User.exists?(library_card: user.library_card)
    end
  end
end

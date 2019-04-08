FactoryBot.define do
  factory :order do
    date {rand(1..100).days.from_now}

    after(:build) do |order|
      user = FactoryBot.create :user
      order.user_id = user.id
    end
  end
end

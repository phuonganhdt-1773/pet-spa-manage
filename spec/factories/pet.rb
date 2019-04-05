FactoryBot.define do
  factory :pet do
    name {FFaker::Name.name}
    description {FFaker::Internet.describe}
  end
end

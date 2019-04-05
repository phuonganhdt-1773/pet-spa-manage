FactoryBot.define do
  factory :pet do
    name {FFaker::Name.name}
    description {FFaker::Internet.description}
  end
end

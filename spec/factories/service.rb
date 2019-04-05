FactoryBot.define do
  factory :service do
    name { FFaker::Name.name }
    description {"phuong anh"}
    price { 98.2 }
    status {1}
    picture {"abc"}
  end
end

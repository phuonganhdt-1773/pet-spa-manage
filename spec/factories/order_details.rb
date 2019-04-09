FactoryBot.define do
  factory :order_detail do
    price {12}
    order_id {1}
    pet_id {1}
    service_id {1}
  end
end

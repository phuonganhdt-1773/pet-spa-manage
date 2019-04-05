FactoryBot.define do
  factory :user do
    name {FFaker::Name.name}
    phone {FFaker::PhoneNumberCU.e164_home_work_phone_number}
    address {FFaker::Address.city}
    email {FFaker::Internet.email}
    password {"abc123"}
    password_confirmation {"abc123"}
    activated {true}
  end
end

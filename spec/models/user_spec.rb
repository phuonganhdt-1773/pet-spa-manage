require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) {FactoryBot.create :user}

  context "attributes" do
    it "Attributes " do
      expect(User.new.attributes.keys).to include("id", "name", "email",
        "phone", "address", "password_digest", "remember_digest",
        "activation_digest", "activated", "activated_at", "reset_digest",
        "reset_send_at", "admin", "created_at", "updated_at")
    end
  end

  context "Associations" do
    it {is_expected.to have_many :orders}
    it {is_expected.to have_many :likes}
    it {is_expected.to have_many :comments}
  end

  context "Validations" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name)
      .is_at_most Settings.max_name_lenght}
    it {is_expected.to validate_presence_of :address}
    it {is_expected.to validate_length_of(:address)
      .is_at_most Settings.max_address_lenght}
    it {is_expected.to validate_presence_of :phone}
    it {is_expected.to validate_length_of(:phone)
      .is_equal_to Settings.phone_lenght}
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email)
      .is_at_most Settings.max_email_lenght}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    describe "email with invalid format is invalid " do
      it {is_expected.to allow_value("email@address.com").for(:email)}
      it {is_expected.not_to allow_value("foo").for(:email)}
    end
    it {is_expected.to have_secure_password}
    it {is_expected.to validate_length_of(:password)
      .is_at_least Settings.min_pass_lenght}
  end

  describe ".class_method" do
    it {expect(User.digest("Lien") == FFaker::Internet.password)}
    it {expect(User.new_token) == SecureRandom.urlsafe_base64}
    it {expect(User.search("Lien") == user)}
  end

  describe "#instance_method" do
    it {expect(user.remember) == true}
    it {expect(user.authenticated?("password", FFaker::String) == (SecureRandom.urlsafe_base64))}
    it {expect(user.forget) == true}
    it {expect(user.activate) == true}
    it {expect(user.create_reset_digest) == true}
  end
end

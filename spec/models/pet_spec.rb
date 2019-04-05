require "rails_helper"

RSpec.describe Pet, type: :model do
  context "attributes" do
    it "Attributes " do
      expect(Pet.new.attributes.keys).to include("id", "name", "description",
        "created_at", "updated_at")
    end
  end

  context "Associations" do
    it {is_expected.to have_many :order_details}
  end

  context "Validations" do
    let(:pet) {create :pet}
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name)
      .is_at_most Settings.max_name_lenght}
    it {is_expected.to validate_presence_of :description}
    it {is_expected.to validate_length_of(:description)
      .is_at_most Settings.max_sumary_length}
  end

  describe "#scope" do
    let!(:pet1) {FactoryBot.create :pet}
    let!(:pet2) {FactoryBot.create :pet}
    it {expect(Pet.by_lastest) == [pet1, pet2]}
    it {expect(Pet.all_pets) == pet1}
  end

  describe ".class_method" do
    let!(:pet1) {FactoryBot.create :pet}
    it {expect(Pet.search("Lien"))}
  end
end

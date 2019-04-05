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
    let!(:pet1) {Pet.create :id => 12, :name => "Lien", :created_at => 1.day.ago}
    let!(:pet2) {Pet.create :id => 13, :name => "Phuong Anh",:created_at => 2.day.ago}
    it {expect(Pet.by_lastest) == [pet1, pet2]}
    it {expect(Pet.all_pets) == pet1}
  end

  describe ".class_method" do
    let!(:pet1) {Pet.create :name => "Lien", :description => "adsfdrftgyui"}
    it {expect(Pet.search("Lien"))}
  end
end

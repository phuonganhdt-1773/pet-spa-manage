require "rails_helper"

RSpec.describe Service, type: :model do
  context "#have attributes" do
    it "have attributes " do
      expect(Service.new.attributes.keys).to include("name", "status", "description", "price")
    end
  end

  context "#Relationships" do
    it { is_expected.to have_many(:order_details) }
  end

  describe "#Validations" do
    let(:service) { create :service }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most Settings.max_service_name }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price)}
  end

  context "#scope" do
    let!(:service_one) { FactoryBot.create :service }
    let!(:service_two) { FactoryBot.create :service }

    it { expect(Service.by_lastest).to match_array([service_one, service_two]) }
    it { expect(Service.most_service(service_one.id)).to match_array([service_one]) }
    it { expect(Service.get_attr).to match_array([service_one, service_two]) }

    it { expect(Service.get_attr.public_service.all_services).to match_array([service_one, service_two]) }
    it { expect(Service.public_service).to match_array([service_one, service_two]) }
    it { expect(Service.public_service.other_services(service_one.id)).to match_array([service_two]) }
  end

  context "#Enum" do
    it { is_expected.to define_enum_for(:status).with(Pending: 0, Public: 1) }
  end
end

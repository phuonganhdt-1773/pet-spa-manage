require "rails_helper"

RSpec.describe Order, type: :model do
  context "#have attributes" do
    it "have attributes " do
      expect(Order.new.attributes.keys).to include("user_id", "date")
    end
  end

  context "#Relationships" do
    it { is_expected.to have_many(:order_details).dependent(:destroy) }
    it { is_expected.to belong_to(:user) }
  end

  describe "#Validations" do
    let(:order) { FactoryBot.create :order }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  context "#scope" do
    let!(:order_one) { FactoryBot.create :order}
    let!(:order_two) { FactoryBot.create :order }

    it { expect(Order.by_lastest).to contain_exactly(order_one, order_two) }
  end

  context "#Enum" do
    it { is_expected.to define_enum_for(:status).with(Pending: 0, Public: 1) }
  end
end

require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  let!(:order) {FactoryBot.create :order}
  let!(:service) {FactoryBot.create :service}
  let!(:pet) {FactoryBot.create :pet}
  let!(:order_detail) {FactoryBot.create :order_detail}
  subject {order_detail}

  context "attributes" do
    it "Attributes " do
      expect(OrderDetail.new.attributes.keys).to include("id", "order_id",
        "pet_id", "service_id", "price", "created_at", "updated_at")
    end
  end

  context "Associations" do
    it {is_expected.to belong_to :order}
    it {is_expected.to belong_to :pet}
    it {is_expected.to belong_to :service}
  end

  describe "#scope" do
    it {expect(OrderDetail.count_max.to match_array([1, 98.2]))}
    it {expect(OrderDetail.detail(order_detail.order_id).to match_array([
      :id, :price, :service_id, :order_id, :pet_id
    ]))}
  end

  describe ".class_method" do
    it {expect(OrderDetail.revenue("2019").to match_array([1, 12]))}
  end
end

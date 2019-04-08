require "rails_helper"

RSpec.describe Comment, type: :model do
  context "#have attributes" do
    it "have attributes " do
      expect(Comment.new.attributes.keys).to include("user_id", "content", "post_id")
    end
  end

  context "#Relationships" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  context "#scope" do
    let(:comment_one) { FactoryBot.create :comment }
    let(:comment_two) { FactoryBot.create :comment }

    it { expect(Comment.by_lastest).to match_array([ comment_one, comment_two ]) }
    it { expect(Comment.count_cmt(comment_one.post_id)).to eq(1)}
    it { expect(Comment.lastest_by_post(comment_one.post_id)).to match_array([ comment_one ])}
  end
end

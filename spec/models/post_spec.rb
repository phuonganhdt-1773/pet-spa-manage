require "rails_helper"

RSpec.describe Post, type: :model do
  let!(:post) {FactoryBot.create :post}
  subject {post}

  context "attributes" do
    it "Attributes " do
      expect(Post.new.attributes.keys).to include("id", "title", "sumary",
        "content", "status", "picture", "like_quantity", "created_at", "updated_at")
    end
  end

  context "Associations" do
    it {is_expected.to have_many :likes}
    it {is_expected.to have_many :comments}
  end

  context "Validations" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_length_of(:title)
      .is_at_most Settings.max_title_length}
    it {is_expected.to validate_presence_of :sumary}
    it {is_expected.to validate_length_of(:sumary)
      .is_at_most Settings.max_sumary_length}
    it {is_expected.to validate_length_of(:content)
      .is_at_least Settings.min_content_length}
  end

  context "#Enum" do
    it {is_expected.to define_enum_for(:status).with %i(Pending Public)}
  end

  describe "#scope" do
    let!(:post1) {FactoryBot.create :post}
    let!(:post2) {FactoryBot.create :post}
    it {expect(Post.acive_post.to match_array([post1, post2, post]))}
    it {expect(Post.get_attr.to match_array([:id, :title, :sumary, :picture, :content]))}
    it {expect(Post.most_likes.to match_array([post1, post2, post]))}
    it {expect(Post.other_posts(post).to match_array([post1, post2]))}
    it {expect(Post.all_posts.to match_array([post1, post2, post]))}
    it {expect(Post.by_lastest).to match_array([post2, post1, post])}
  end

  describe ".class_method" do
    it {expect(Post.search("a").to match_array(post2, post1, post))}
  end
end

require "rails_helper"

RSpec.describe User, type: :model do
  describe "#can_view_resque?" do
    it "allows developers to view resque" do
      user = build(:user, role: 3)

      expect(user.can_view_resque?).to eql(true)
    end

    it "prevents non developers from viewing resque" do
      user0 = build(:user, role: 0)
      user1 = build(:user, role: 1)
      user2 = build(:user, role: 2)

      expect(user0.can_view_resque?).to eql(false)
      expect(user1.can_view_resque?).to eql(false)
      expect(user2.can_view_resque?).to eql(false)
    end
  end
end

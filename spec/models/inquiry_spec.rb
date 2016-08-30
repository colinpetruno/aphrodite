require "rails_helper"

RSpec.describe Account, type: :model do
  describe ".from_user" do
    context "given a user" do
      it "should set the user_id" do
        user = create(:user)
        inquiry = Inquiry.from_user(user)

        expect(inquiry.user_id).to eql(user.id)
      end
    end

    context "without a user" do
      it "should leave the user_id blank" do
        inquiry = Inquiry.from_user

        expect(inquiry.user_id).to eql(nil)
      end
    end
  end
end

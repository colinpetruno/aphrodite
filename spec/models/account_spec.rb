require "rails_helper"

RSpec.describe Account, type: :model do
  describe "#valid?" do
    it "should set the url to include http" do
      account = build :account, site_url: "www.example2.com"
      account.valid?

      expect(account.site_url).to eql "http://www.example2.com"
    end
  end
end

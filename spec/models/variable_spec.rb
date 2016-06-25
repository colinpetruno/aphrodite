require "rails_helper"

RSpec.describe Variable, type: :model do
  describe "#where" do
    it "should return records in the proper order" do
      stylesheet = create(:stylesheet)
      variable1 = create(:variable, position: 3, stylesheet: stylesheet)
      variable2 = create(:variable, position: 1, stylesheet: stylesheet)
      variable3 = create(:variable, position: 2, stylesheet: stylesheet)
      stylesheet.reload

      expect(stylesheet.variables.map(&:id)).
        to eql([variable2.id, variable3.id, variable1.id])
    end
  end
end

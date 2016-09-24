require "rails_helper"

RSpec.describe Variable, type: :model do
  describe ".from" do
    it "should return a variable with the same properties" do
      default_variable = create(:default_variable)
      variable = Variable.from(default_variable)

      expect(variable.name).to eql(default_variable.name)
      expect(variable.default).to eql(true)
      expect(variable.category_id).to eql(default_variable.category_id)
      expect(variable.variable_type).to eql(default_variable.variable_type)
      expect(variable.value).to eql(default_variable.value)
      expect(variable.preview_value).to eql(default_variable.value)
      expect(variable.position).to eql(default_variable.position)
    end
  end

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

  describe "#input_type" do
    context "if it is nil" do
      it "shhould return :string" do
        variable = create(:variable, variable_type: nil)
        expect(variable.input_type).to eql(:string)
      end
    end

    context "if it is not nil" do
      it "should be returned as a symbol" do
        variable = create(:variable, variable_type: 0)
        expect(variable.input_type).to eql(:color)
      end
    end
  end
end

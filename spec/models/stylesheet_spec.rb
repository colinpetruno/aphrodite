require "rails_helper"

RSpec.describe Stylesheet, type: :model do
  it { should validate_presence_of(:framework) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:version) }

  describe ".framework_select_options" do
    it "should return an array of arrays of available frameworks" do
      result = Stylesheet.framework_select_options

      expect(result).to be_an(Array)
      expect(result.size).to eql(Stylesheet::VERSIONS.keys.length)
      expect(result.first).to be_an(Array)
      expect(result.first.size).to eql(2)
    end
  end

  describe "#filename" do
    it "should properly format the file name" do
      stylesheet = Stylesheet.new(name: "Bootstrap 3 demo")
      expect(stylesheet.filename).to eql("bootstrap-3-demo.min.css")
    end

    context "as a preview" do
      it "should not be minified" do
        stylesheet = Stylesheet.new(name: "Style 3 demo")
        expect(stylesheet.filename(preview: true)).to eql("style-3-demo.css")
      end
    end
  end
end

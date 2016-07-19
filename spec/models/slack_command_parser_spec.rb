require "rails_helper"

RSpec.describe SlackCommandParser, type: :model do
  describe "#new" do
    it "should be case insensitive" do
      result = SlackCommandParser.new("help").parse

      expect(result[:command]).to eql("help")

      result = SlackCommandParser.new("hElP").parse

      expect(result[:command]).to eql("help")
    end
  end
  describe "#parse" do
    context "when asking for help" do
      it "should return a hash with the help command" do
        result = SlackCommandParser.new("help").parse

        expect(result[:command]).to eql("help")
      end
    end

    context "when asking to list all stylesheets" do
      it "should return a list of ids and names" do
        result = SlackCommandParser.new("stylesheets/index").parse

        expect(result[:command]).to eql("list_stylesheets")
      end
    end
  end
end

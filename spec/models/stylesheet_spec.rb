require "rails_helper"

RSpec.describe Stylesheet, type: :model do
  it { should validate_presence_of(:framework) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:version) }
end

FactoryGirl.define do
  factory :stylesheet do
    account

    name "Stylesheet Name"
    framework "bootstrap"
    version "3.3"
  end
end

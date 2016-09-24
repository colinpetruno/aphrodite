FactoryGirl.define do
  factory :default_variable do
    category

    sequence(:position)

    name "$someVariable"
    value "#392339"
    framework "bootstrap"
    version "4"
  end
end

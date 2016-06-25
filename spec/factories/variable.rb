FactoryGirl.define do
  factory :variable do
    category
    stylesheet

    sequence(:position)

    name "$someVariable"
    value "#392339"
    preview_value "#9409f3"
    default true
  end
end

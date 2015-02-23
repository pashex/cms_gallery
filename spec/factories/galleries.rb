FactoryGirl.define do
  factory :gallery do
    sequence(:name) { |n| "gallery_#{n}_name" }

  end

end

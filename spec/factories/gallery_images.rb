FactoryGirl.define do
  factory :gallery_image do
    sequence(:name) { |n| "gallery_image_#{n}_name" }   
  end

end

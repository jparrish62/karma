FactoryGirl.define do
  factory :stylist do
    image  { File.new(Rails.root.join('spec', 'support', 'stylist.png')) }
  end
end

FactoryGirl.define do
  factory :work do
    body "Foobar"
    image  { File.new(Rails.root.join('spec', 'support', 'work.jpeg')) }
  end
end

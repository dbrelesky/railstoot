FactoryGirl.define do
  factory :user do
    name     "George Washington"
    email    "george@dollarbill.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
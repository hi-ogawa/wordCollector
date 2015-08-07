FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.email}
    password "12345678"
    password_confirmation "12345678"
  end

  factory :user_wrong_email, class: User do
    email "not very well"
    password "12345678"
    password_confirmation "12345678"
  end

  factory :user_wrong_password, class: User do
    email {FFaker::Internet.email}
    password "1234567"
    password_confirmation "1234567"
  end

  factory :user_wrong_password_confirmation, class: User do
    email {FFaker::Internet.email}
    password "12345678"
    password_confirmation "123456789"
  end
end

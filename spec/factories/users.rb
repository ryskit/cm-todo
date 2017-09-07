FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "example_name_#{n}"}
    sequence(:email) { |n| "example#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
    uuid 'f504ac63d55b6b0da66ef938ba5e38877c5105c329205e37d1822aa2bf3d44e8e28fb8586ea727b6b84fd06f4adbdf300ff5d23ec95a500a8310488c769ba5b1'
  end
  
  factory :user_params, class: User do
    sequence(:name) { |n| "example_name_#{n}"}
    sequence(:email) { |n| "example_user#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
  end
  
  factory :updated_user_name, class: User do
    name 'updated_example_name'
  end

  factory :updated_user_email, class: User do
    sequence(:email) { |n| "example#{n}@example.com"}
  end
end
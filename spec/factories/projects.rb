FactoryGirl.define do
  sequence(:name) { |n| "project_name_#{n}" }
    
  factory :valid_params, class: Project do
    name
  end

  factory :invalid_params, class: Project do
    name 'a' * 51
  end
  
  factory :valid_update_params, class: Project do
    sequence(:name) { |n| "update_project_name_#{n}" }
  end
end

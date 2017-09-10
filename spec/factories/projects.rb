FactoryGirl.define do
  sequence(:name) { |n| "project_name_#{n}" }
    
    factory :valid_params, class: Project do
      name
    end
end

FactoryGirl.define do
  
  sequence(:title) { |n| "title_#{n}" }
  sequence(:content) { |n| "content_#{n}" }
  sequence(:due_to) { |n| n.days.since.end_of_day}
  
  factory :task do
    title
    content
    due_to
  end
  
  factory :valid_task_attributes, class: Task do
    title
    content
  end

  factory :invalid_task_attributes, class: Task do
    title ''
    content '' 
  end
  
  factory :update_task_attributes, class: Task do 
    sequence(:title) { |n| "updated title #{n}" }
    sequence(:content) { |n| "updated content #{n}" }
    sequence(:due_to) { |n| n.day.since.beginning_of_day }
  end
  
end
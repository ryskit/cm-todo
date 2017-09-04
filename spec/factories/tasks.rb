FactoryGirl.define do
  factory :task do
    title 'title'
    content 'contentcontent'
  end
  
  factory :valid_task_params, class: Task do
    title 'title'
    content 'content'
  end

  factory :invalid_task_params, class: Task do
    title ''
    content '' 
    checked 'aaaaaa'
  end
end
class Project < ApplicationRecord
  has_many :project_tasks
  has_many :tasks, through: :project_tasks
  belongs_to :user
  
  validates :name,
            presence: true,
            length: { maximum: 50 }
end
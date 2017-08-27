class Task < ApplicationRecord
  belongs_to :user
  
  scope :q, -> q {where('title LIKE(?) OR content LIKE(?)', "%#{q}%", "%#{q}%") if q.present?}
  scope :user_id, -> user_id {where(user_id: user_id) if user_id.present?}
  scope :title, -> title {where('title LIKE(?)', "#{title}%") if title.present?}
  scope :content, -> content {where('content LIKE(?)', "#{content}%") if content.present?}
  scope :checked, -> checked {where(checked: !!checked || false)}
  scope :next_days, -> next_days {
    where(due_to: (Time.now.beginning_of_day)..(next_days.days.since) ) if next_days.present?
  }
  scope :expired, -> expired {
    comparison = !!expired ? "<" : ">"
    where("due_to #{comparison} ?", Time.now) unless expired.nil?
  }

  validates :title, presence: true, length: {maximum: 50} 
  validates :content, length: {maximum: 2000}
end

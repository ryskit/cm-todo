class Task < ApplicationRecord
  belongs_to :user
  
  scope :by_q, -> q {where('title LIKE(?) OR content LIKE(?)', "%#{q}%", "%#{q}%") if q.present?}
  scope :by_user_id, -> user_id {where(user_id: user_id) if user_id.present?}
  scope :by_title, -> title {where('title LIKE(?)', "%#{title}%") if title.present?}
  scope :by_content, -> content {where('content LIKE(?)', "%#{content}%") if content.present?}
  scope :by_checked, -> checked {where(checked: !!checked || false)}
  scope :by_next_days, -> next_days {
    where(due_to: (Time.now.beginning_of_day)..(next_days.to_i.days.since.end_of_day) ) if next_days.present?
  }
  scope :by_expired, -> expired {
    comparison = !!expired ? "<" : ">"
    where("due_to #{comparison} ?", Time.now) unless expired.nil?
  }

  validates :title, presence: true, length: {maximum: 50} 
  validates :content, length: {maximum: 2000}
end

class User < ApplicationRecord
  
  has_many :tasks
  
  has_secure_password
  
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :name, presence: true, length: {minimum: 1, maximum: 100}
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: VALID_EMAIL_REGEX,
                    uniqueness: {case_sensitive: false}
  
  
  private
    
    def downcase_email
      self.email.downcase!
    end
  
end

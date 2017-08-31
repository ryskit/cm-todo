class User < ApplicationRecord
  has_secure_password 
  
  has_many :tasks
  has_many :refresh_tokens
  
  before_save :downcase_email
  before_create :create_uuid

  VALID_EMAIL_REGEX = /\A[\w\+\-\.]+[a-zA-Z\d]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*\.[a-zA-Z]+\z/i
  
  validates :name, presence: true, length: {minimum: 1, maximum: 100}
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: VALID_EMAIL_REGEX,
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :uuid, presence: true, length: {is: 128}, uniqueness: {case_sensitive: false}
  
  
  private
    
    def downcase_email
      self.email.downcase!
    end
  
    def create_uuid
      self.uuid = SecureRandom.hex(64)
    end
  
end

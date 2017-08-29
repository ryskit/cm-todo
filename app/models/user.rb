class User < ApplicationRecord
  has_secure_password 
  
  has_many :tasks
  has_many :refresh_tokens
  
  before_save :downcase_email
  before_create :create_uuid

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates :name, presence: true, length: {minimum: 1, maximum: 100}
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: VALID_EMAIL_REGEX,
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  private
    
    def downcase_email
      self.email.downcase!
    end
  
    def create_uuid
      self.uuid = SecureRandom.hex(128)
    end
  
end

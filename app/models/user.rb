class User < ApplicationRecord
  has_secure_password 
  
  has_many :tasks
  has_many :refresh_tokens

  attr_accessor :old_password, :password_validation
  
  before_save :downcase_email
  before_create :create_uuid

  VALID_EMAIL_REGEX = /\A[\w\+\-\.]+[a-zA-Z\d]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*\.[a-zA-Z]+\z/i
  
  validates :name,  
            presence: true,
            length: { minimum: 1, maximum: 100 }
  
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: VALID_EMAIL_REGEX,
            uniqueness: { case_sensitive: false }


  with_options if: :enable_password_validation? do
    
    validates :password,
              presence: true,
              length: {minimum: 6},
              on: [:create, :update]

    validates :password_confirmation,
              presence: true,
              length: {minimum: 6},
              confirmation: true,
              on: [:create, :update]
    
    validates :old_password,
              presence: true,
              length: {minimum: 6},
              on: :update
  end

  validates :uuid,
            presence: true,
            length: { is: 128, on: :create },
            uniqueness: {case_sensitive: false},
            allow_nil: true,
            on: :create

  def authenticated?(password)
    return false if password_digest.nil?
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def update_account(update_account_params)
    self.password_validation = false
    update(update_account_params)
  end
  
  private
    
    def downcase_email
      self.email.downcase!
    end
  
    def create_uuid
      self.uuid = SecureRandom.hex(64)
    end

    def enable_password_validation?
      password_validation.nil? ? true : password_validation
    end
end

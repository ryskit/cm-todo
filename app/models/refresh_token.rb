class RefreshToken < ApplicationRecord
  belongs_to :user
  
  before_create :create_refresh_token, :create_expiration_at
  
  private
    
    def create_refresh_token
      self.token = SecureRandom.hex(128)
    end
  
    def create_expiration_at
      self.expiration_at= 1.years.since
    end
  
end
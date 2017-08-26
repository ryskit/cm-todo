class RefreshToken < ApplicationRecord
  belongs_to :user
  
  before_create :create_refresh_token, :create_expiration
  
  private
    
    def create_refresh_token
      self.token = SecureRandom.hex(64)
    end
  
    def create_expiration
      self.expiration = 1.years.since.to_i
    end
  
end
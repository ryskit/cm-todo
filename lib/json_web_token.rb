class JsonWebToken
  class << self
    
    ACCESS_TOKEN_SECRET_KEY = Rails.application.secrets.access_token_secret_key
    REFRESH_TOKEN_SECRET_KEY = Rails.application.secrets.refresh_token_secret_key
    
    
    def create_access_token(payload = {}, algorithm = 'HS512')
      default_payload = {
        :iss => 'ToDo App',
        :sub => 'Refresh Token',
        :exp => 24.hours.since.to_i,
        :ngf => 5.seconds.ago.to_i,
        :iat => Time.now.to_i
      }

      payload.merge! default_payload
      JWT.encode payload, ACCESS_TOKEN_SECRET_KEY, algorithm
    end
    
    
    def decode_access_token(token, algorithm = 'HS512')
      begin
        JWT.decode token, ACCESS_TOKEN_SECRET_KEY, true, { :algorithm => algorithm }
      rescue JWT::ExpiredSignature
        nil
      end
    end
    
  end
end
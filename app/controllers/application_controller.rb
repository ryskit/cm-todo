class ApplicationController < ActionController::API
  
  
  private
  
    def render_403
      render json: {
        status: 'NG',
        code: 403,
        error: Rack::Utils::HTTP_STATUS_CODES[403],
      }, status: :forbidden
    end

    def render_404
      render json: {
        status: 'NG',
        code: 404,
        error: Rack::Utils::HTTP_STATUS_CODES[404],
      }, status: :not_found
    end
    
    def render_500
      render json: {
        status: 'NG',
        code: 500,
        error: Rack::Utils::HTTP_STATUS_CODES[500],
      }, status: :internal_server_error
    end
end

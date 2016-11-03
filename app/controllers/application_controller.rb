class ApplicationController < ActionController::API

  private

  def current_user
    puts params[:api_token]
    @current_user ||= User.find_by(api_token: params[:api_token])
  end

  def require_user
    if !current_user
      render json: ["You must be authenticated to do this"], status: :forbidden
    end
  end

end

class ApplicationController < ActionController::API
  def authenticate_user!
    api_key = ApiKey.find_by(token: request.session[:token])
    @current_user = api_key&.bearer
    head :unauthorized unless @current_user # previous "head :unauthorized unless @current_user if @current_user.nil? " is weird, we check the same thing (@current_user) twice - DRY.
  end

  def current_user #standard convention in Rails
    @current_user
  end
end

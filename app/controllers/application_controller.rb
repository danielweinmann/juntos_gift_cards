class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_api!, if: -> { request.headers["HTTP_AUTHORIZATION"].present? }
  skip_before_filter :verify_authenticity_token, if: -> { request.headers["HTTP_AUTHORIZATION"].present? }
  after_action :verify_authorized, unless: -> {devise_controller?}
  after_action :verify_policy_scoped, only: %i[index], unless: -> {devise_controller?}
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  responders :flash, :location

  helper_method :namespace

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def user_not_authorized(exception)
    flash[:alert] = t('flash.not_authorized')
    redirect_to(request.referrer || root_path)
  end

  def namespace
    names = self.class.to_s.split('::')
    return "null" if names.length < 2
    names[0..(names.length-2)].map(&:downcase).join('_')
  end

  def authenticate_api!
    authenticate_or_request_with_http_token do |token, options|
      api_key = ApiKey.not_expired.find_by_access_token(token)
      if api_key
        sign_in(:user, api_key.user)
      else
        return render json: { error: t('unauthorized') }, status: :unauthorized
      end
    end
  end

end

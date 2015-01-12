class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :exception

  after_action :verify_authorized, except: %i[index], unless: -> {devise_controller?}
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

end

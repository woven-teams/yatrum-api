class ApplicationController < ActionController::Base
  include Authenticable
  include Common
  # before_action :set_current_user
  # protect_from_forgery with: :null_session
  before_action :authenticate_api

  # This authentication should be at the controller level
  attr_reader :current_user

  def current_user
    @current_user
  end

  def authenticate_api
    # Dirty checking for admin user.
    # TODO: Need to correctly implement this
    # issue: Devise not sending user auth details in headers instead it sends in params
    # our code is implemented to check headers. hence the whole if else hack below
    if params[:user].try(:[], :email) == ENV['ADMIN_EMAIL']
      # return admin user
      # TODO: must check for auth token and other stuff to decode
      # the token and find user
      @current_user = User.find_by(email: ENV['ADMIN_EMAIL'])
    else
      @current_user = AuthorizeApiRequest.call(request.headers).result
      Thread.current[:current_user] = @current_user
    end
  end

  # Override Devise after sign in path for different user role
  def after_sign_in_path_for(resource)
    if current_user.admin?
      rails_admin.dashboard_path
    else
      user_path(current_user)
    end
  end
end

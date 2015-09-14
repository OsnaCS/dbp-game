class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_filter :check_login
  protect_from_forgery with: :exception
  before_action :authenticate_user! , :except => [:new]
  before_action :check_if_user_own_ship
  
  protected

  def check_if_user_own_ship
    if user_signed_in? 
      if current_user.activeShip == nil 
        redirect_to new_ship_path
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
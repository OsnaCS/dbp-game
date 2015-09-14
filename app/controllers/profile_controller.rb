class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@user = current_user
  end

  def user
  	@user = User.find_by_username(params[:username])
  end

end

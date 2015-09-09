class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	if current_user.user_ships == nil 
	  redirect_to :controller => 'ships', :action => 'new'
	end
  end
end

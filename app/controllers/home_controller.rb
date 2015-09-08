class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
  	if UserShip.find_by_user_id(current_user) == nil 
		redirect_to :controller => 'ships', :action => 'new'
	end
  end
end

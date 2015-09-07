class ProfileController < ApplicationController
  before_filter :authenticate_user!

  def index
  	@user = current_user
  end

  def user
  	@user = User.find_by_username(params[:user])
  end

  def upload
    uploaded_io = params[:person][:picture]
	File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
	  file.write(uploaded_io.read)
	end
  end
end

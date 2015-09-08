class UserIconsController < ApplicationController
  before_action :set_user_icon, only: [:show, :edit, :update, :destroy]

  # GET /user_icons
  # GET /user_icons.json
  def index
    @user_icons = UserIcon.all
  end

  # GET /user_icons/1
  # GET /user_icons/1.json
  def show
  end

  # GET /user_icons/new
  def new
    @user_icon = UserIcon.new
  end

  # GET /user_icons/1/edit
  def edit
  end

  # POST /user_icons
  # POST /user_icons.json
  def create
    @user_icon = UserIcon.new(user_icon_params)
    #@user_icon = UserIcon.new(user_icon_params)
    @user_icon.user_id = current_user.id
    respond_to do |format|
      if @user_icon.save
        format.html { redirect_to @user_icon, notice: 'User icon was successfully created.' }
        format.json { render :show, status: :created, location: @user_icon }
      else
        format.html { render :new }
        format.json { render json: @user_icon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_icons/1
  # PATCH/PUT /user_icons/1.json
  def update
    respond_to do |format|
      if @user_icon.update(user_id: current_user.id)
        format.html { redirect_to @user_icon, notice: 'User icon was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_icon }
      else
        format.html { render :edit }
        format.json { render json: @user_icon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_icons/1
  # DELETE /user_icons/1.json
  def destroy
    @user_icon.destroy
    respond_to do |format|
      format.html { redirect_to user_icons_url, notice: 'User icon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_icon
      @user_icon = UserIcon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_icon_params
      params.require(:user_icon).permit(:user_id, :image)
    end
end

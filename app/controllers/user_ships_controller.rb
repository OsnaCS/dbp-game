class UserShipsController < ApplicationController
  before_action :set_user_ship, only: [:show, :edit, :update, :destroy]

  # GET /user_ships
  # GET /user_ships.json
  def index
    @user_ships = UserShip.all
  end

  # GET /user_ships/1
  # GET /user_ships/1.json
  def show
  end

  # GET /user_ships/new
  def new
    @user_ship = UserShip.new
  end

  # GET /user_ships/1/edit
  def edit
  end

  # POST /user_ships
  # POST /user_ships.json
  def create
    @user_ship = UserShip.new(user_ship_params)

    respond_to do |format|
      if @user_ship.save
        format.html { redirect_to @user_ship, notice: 'User ship was successfully created.' }
        format.json { render :show, status: :created, location: @user_ship }
      else
        format.html { render :new }
        format.json { render json: @user_ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_ships/1
  # PATCH/PUT /user_ships/1.json
  def update
    respond_to do |format|
      if @user_ship.update(user_ship_params)
        format.html { redirect_to @user_ship, notice: 'User ship was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_ship }
      else
        format.html { render :edit }
        format.json { render json: @user_ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_ships/1
  # DELETE /user_ships/1.json
  def destroy
    @user_ship.destroy
    respond_to do |format|
      format.html { redirect_to user_ships_url, notice: 'User ship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_ship
      @user_ship = UserShip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_ship_params
      params.require(:user_ship).permit(:user_id, :ship_id)
    end
end

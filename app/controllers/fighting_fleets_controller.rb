class FightingFleetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fighting_fleet, only: [:show, :edit, :update, :destroy]
  # GET /fighting_fleets
  # GET /fighting_fleets.json

  def index
    @fighting_fleets=FightingFleet.all	
  end

  def user
  	@user = User.find_by_username(params[:user])
  end

  # GET /fighting_fleets/1
  # GET /fighting_fleets/1.json
  def show
   
  end

  # GET /fighting_fleets/new
  def new
    @fighting_fleet = FightingFleet.new
      @defend_user = params[:defend_user]
     
  end

  # GET /fighting_fleets/1/edit
  def edit

  end

  # POST /fighting_fleets
  # POST /fighting_fleets.json
  def create
  
    current_user.active_ship
    @fighting_fleets = FightingFleet.all
    @fighting_fleet = FightingFleet.new(fighting_fleet_params)
    @fighting_fleet.fight.attacker_id = current_user.id
    #@fighting_fleet.fight.defender_id = User.find(@defend_user)
    @fighting_fleet.user_id=current_user.id
    respond_to do |format|
      if @fighting_fleet.save
        format.html { redirect_to fight_path(id: @fighting_fleet.fight.id), notice: 'Fighting fleet was successfully created.' }
        format.json { render :index, status: :created, location: @fighting_fleet }
      else
        format.html { render :new }
        format.json { render json: @fighting_fleet.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /fighting_fleets/1
  # PATCH/PUT /fighting_fleets/1.json
  def update
    respond_to do |format|
      if @fighting_fleet.update(fighting_fleet_params)
        format.html { redirect_to @fighting_fleet, notice: 'Fighting fleet was successfully updated.' }
        format.json { render :show, status: :ok, location: @fighting_fleet }
      else
        format.html { render :edit }
        format.json { render json: @fighting_fleet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fighting_fleets/1
  # DELETE /fighting_fleets/1.json
  def destroy
    @fighting_fleet.destroy
    respond_to do |format|
      format.html { redirect_to fighting_fleets_url, notice: 'Fighting fleet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fighting_fleet
      @fighting_fleet = FightingFleet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fighting_fleet_params
      params.require(:fighting_fleet).permit(:shield, :user_id, :name, ship_groups_attributes: [:unit_id, :number, :group_hitpoints],fight_attributes: [:attacker_id, :defender_id, :ship_defend_id, :ship_attack_id])
    end
end

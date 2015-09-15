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
    @target = User.find_by(:id => params[:user_id])
  end

  # GET /fighting_fleets/1/edit
  def edit
  end

  # POST /fighting_fleets
  # POST /fighting_fleets.json
  def create
    @fighting_fleet = FightingFleet.new(fighting_fleet_params)
    @target_ship = Ship.find_by(:id => params[:fighting_fleet][:user][:Schiff])
    @target = @target_ship.user
    @fighting_fleet.target_ship = @target_ship.id
    
    @fighting_fleet.fight.defender_id = @target.id
    @fighting_fleet.fight.save

    @fighting_fleet.fight.attacker_id=current_user.id
    @fighting_fleet.user_id=current_user.id
    @fighting_fleet.state = 1
    @fighting_fleet.start_time = Time.now
    @fighting_fleet.mission = params[:fighting_fleet][:mission]

    @metal_cargo = params[:metal_cargo]
    @crystal_cargo = params[:crystal_cargo]
    @fuel_cargo = params[:fuel_cargo]

    data = @metal_cargo + ":" + @crystal_cargo + ":" + @fuel_cargo + "," + @target_ship.id.to_s
    @fighting_fleet.data = data
    @fighting_fleet.save


    fuelcost = 0

    Unit.all.each do |unit|
       fuelcost += (unit.shell + unit.cargo) * params[unit.id.to_s].to_i
    end
    userShip = Ship.find(current_user.activeShip)

    Unit.all.each do |unit|
      ship_group = @fighting_fleet.ship_groups.find_by(:unit_id => unit.id)

      if(ship_group.nil?)
        ship_group = ShipGroup.new
        ship_group.unit_id = unit.id
        ship_group.number = params[unit.id.to_s].to_i
        ship_group.fighting_fleet_id = @fighting_fleet.id
        ship_group.save
      else
        ship_group.number = params[unit.id.to_s].to_i
        ship_group.save
      end
    end
    
    userShip.fuel -= fuelcost
    userShip.save

    respond_to do |format|
      if @fighting_fleet.save
        format.html { redirect_to @fighting_fleet, notice: 'Fighting fleet was successfully created.' }
        format.json { render :show, status: :created, location: @fighting_fleet }
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
      params.require(:fighting_fleet).permit(:shield, :user_id, :name, ship_groups_attributes: [:unit_id, :number, :group_hitpoints],fight_attributes: [:attacker_id, :defender_id])
    end
end

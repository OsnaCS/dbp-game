class FightingFleetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_fighting_fleet, only: [:callback, :show, :edit, :update, :destroy]
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
    @max_metal = current_user.active_ship.metal
    @max_crystal = current_user.active_ship.cristal
    @max_fuel = current_user.active_ship.fuel
    userFuelFactor = 1 + (0.1 * current_user.get_science_instance(Science.find_by(:name => "Triebwerke")).level)
    @fuelcost = Hash.new(0)
    Unit.all.each do |unit|
      @fuelcost[unit.id] = ((unit.shell + unit.cargo)/userFuelFactor).to_i
    end
  end

  def callback
    @fighting_fleet.state = 2

    one_way_duration = @fighting_fleet.flight_duration(@fighting_fleet.get_start_ship, @fighting_fleet.get_target_ship)
    travel_time = @fighting_fleet.get_time_since_start - one_way_duration
    @fighting_fleet.start_time = Time.now + (travel_time)
    @fighting_fleet.save
    redirect_to fighting_fleets_url
  end

  # GET /fighting_fleets/1/edit
  def edit
  end

  # POST /fighting_fleets
  # POST /fighting_fleets.json
  def create
    @metal_cargo = params[:metal_cargo].to_i
    @crystal_cargo = params[:crystal_cargo].to_i
    @fuel_cargo = params[:fuel_cargo].to_i
    @target_ship = Ship.find_by(:id => params[:fighting_fleet][:user][:Schiff])
    @target = @target_ship.user
    mission = params[:fighting_fleet][:mission]
    ac_ship = current_user.active_ship

    if not(current_user.has_enough_resources(@metal_cargo, @crystal_cargo, @fuel_cargo))
      redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Nicht genug Ressourcen!'
      return
    end

    total_cargo = 0
    total_amount = 0
    min_speed = -1
    Unit.all.each do |unit|
      check_amount = params[unit.id.to_s].to_i
      total_amount += check_amount
      unit_amount = ac_ship.get_unit_instance(unit).amount
      total_cargo += unit.cargo * check_amount * 500

      if((unit.speed < min_speed && check_amount != 0) || min_speed < 0)
        min_speed = unit.speed
      end

      if(check_amount > unit_amount)
        redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Zu wenig Einheiten am Mutterschiff vorhanden.'
        return
      end
    end
    duration = FightingFleet.static_flight_duration(ac_ship, @target_ship, min_speed)

    if(total_cargo < @metal_cargo + @crystal_cargo + @fuel_cargo)
      redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Zu wenig Laderaum der Einheiten für die Ressourcen.'
      return
    end
    
    if(total_amount == 0)
      redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Es muss mindestens ein Schiff versendet werden!'
      return
    end

    fuelcost = 0
    userFuelFactor = 1 + (0.1 * current_user.get_science_instance(Science.find_by(:name => "Triebwerke")).level)

    Unit.all.each do |unit|
       fuelcost += (unit.shell + unit.cargo) * params[unit.id.to_s].to_i
    end
    total_fuelcost = ((fuelcost * duration) / 200) / userFuelFactor

    if not(current_user.has_enough_fuel(@fuel_cargo + total_fuelcost))
      redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Du besitzt nicht genügend Treibstoff!'
      return
    end

    if(current_user.id == @target.id && mission.to_i == 1)
      redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Du darfst dich nicht selbst angreifen!'
      return
    end

    if(current_user.active_ship.id == @target_ship.id)
      redirect_to new_fighting_fleet_url(:user_id => @target.id), alert: 'Dieses Schiff ist aktuell ausgewaehlt!'
      return
    end
    current_user.remove_resources(@metal_cargo, @crystal_cargo, @fuel_cargo + total_fuelcost, current_user.active_ship)

    @fighting_fleet = FightingFleet.new(fighting_fleet_params)
    @fighting_fleet.target_ship = @target_ship.id
    @fighting_fleet.fight.defender_id = @target.id
    @fighting_fleet.fight.save
    @fighting_fleet.fight.attacker_id=current_user.id
    @fighting_fleet.user_id=current_user.id
    @fighting_fleet.state = 1
    @fighting_fleet.mission = mission
    @fighting_fleet.start_time = Time.now
    @fighting_fleet.start_ship = ac_ship.id
    data = @metal_cargo.to_s + ":" + @crystal_cargo.to_s + ":" + @fuel_cargo.to_s + "," + @target_ship.id.to_s
    @fighting_fleet.data = data
    @fighting_fleet.save

    userShip = Ship.find(current_user.activeShip)
    unit_instance = nil
    number = 
    Unit.all.each do |unit|
      number = params[unit.id.to_s].to_i
      ship_group = @fighting_fleet.ship_groups.find_by(:unit_id => unit.id)

      if(number != 0)
          unit_instance = ac_ship.get_unit_instance(unit)
          unit_instance.amount = unit_instance.amount - number
          unit_instance.save
      end

      if(ship_group.nil?)
        ship_group = ShipGroup.new
        ship_group.unit_id = unit.id
        ship_group.number = number
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
        format.html { redirect_to fighting_fleets_url notice: 'Fighting fleet was successfully created.' }
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

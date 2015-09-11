class ShipsStationsController < ApplicationController
  before_action :set_ships_station, only: [:upgrade, :cancel_upgrade, :instant_upgrade, :show, :edit, :update, :destroy]

  # GET /ships_stations
  # GET /ships_stations.json
  def index
    #Wenn Schiffe existieren
    @ship = Ship.find(params[:ship_id])
    @ships_stations = @ship.ships_stations
  end

  # GET /ships_stations/1
  # GET /ships_stations/1.json
  def show
  end

  # GET /ships_stations/new
  def new
    @ships_station = ShipsStation.new
  end

  # GET /ships_stations/1/edit
  def edit
  end

  # POST /ships_stations
  # POST /ships_stations.json
  def create
    @ships_station = ShipsStation.new(ships_station_params)

    respond_to do |format|
      if @ships_station.save
        format.html { redirect_to @ships_station, notice: 'Ships station was successfully created.' }
        format.json { render :show, status: :created, location: @ships_station }
      else
        format.html { render :new }
        format.json { render json: @ships_station.errors, status: :unprocessable_entity }
      end
    end
  end

  def upgrade
    @ships_station.start_time = Time.now
    @ships_station.save

    metal = @ships_station.station.get_metal_cost(@ships_station.level)
    crystal = @ships_station.station.get_crystal_cost(@ships_station.level)
    fuel = @ships_station.station.get_fuel_cost(@ships_station.level)

    current_user.remove_resources_from_current_ship(metal, crystal, fuel)
    redirect_to ship_ships_stations_url(@ships_station.ship)
  end

  def cancel_upgrade
    currentLevel = @ships_station.level
    station = @ships_station.station

    ratio = @ships_station.get_upgrade_ratio
    reMetal = station.get_metal_cost_ratio(currentLevel, ratio)
    reCrystal = station.get_crystal_cost_ratio(currentLevel, ratio)
    reFuel = station.get_fuel_cost_ratio(currentLevel, ratio)

    current_user.add_resources_to_current_ship(reMetal, reCrystal, reFuel)

    @ships_station.start_time = nil
    @ships_station.save
    redirect_to ship_ships_stations_url(@ships_station.ship)
  end



  def instant_upgrade
    @ships_station.level = @ships_station.level + 1
    @ships_station.start_time = nil
    @ships_station.save
    redirect_to ship_ships_stations_url(@ships_station.ship)
  end

  # PATCH/PUT /ships_stations/1
  # PATCH/PUT /ships_stations/1.json
  def update
    respond_to do |format|
      if @ships_station.update(ships_station_params)
        format.html { redirect_to @ships_station, notice: 'Ships station was successfully updated.' }
        format.json { render :show, status: :ok, location: @ships_station }
      else
        format.html { render :edit }
        format.json { render json: @ships_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships_stations/1
  # DELETE /ships_stations/1.json
  def destroy
    @ships_station.destroy
    respond_to do |format|
      format.html { redirect_to ships_stations_url, notice: 'Ships station was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ships_station
      @ships_station = ShipsStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ships_station_params
      params.require(:ships_station).permit(:ships_id, :stations_id, :level)
    end
end

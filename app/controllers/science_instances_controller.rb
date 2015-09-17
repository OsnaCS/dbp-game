class ScienceInstancesController < ApplicationController
  before_action :set_science_instance, only: [:cheat, :research, :cancel_research, :instant_research, :show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /science_instances
  # GET /science_instances.json
  def index
    @science_instances = ScienceInstance.all
  end

  # GET /science_instances/1
  # GET /science_instances/1.json
  def show
  end

  # GET /science_instances/new
  def new
    @science_instance = ScienceInstance.new
  end

  # GET /science_instances/1/edit
  def edit
  end

  # POST /science_instances
  # POST /science_instances.json
  def create
    @science_instance = ScienceInstance.new(science_instance_params)

    respond_to do |format|
      if @science_instance.save
        format.html { redirect_to @science_instance, notice: 'Science instance was successfully created.' }
        format.json { render :show, status: :created, location: @science_instance }
      else
        format.html { render :new }
        format.json { render json: @science_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def research
    ship = current_user.active_ship
    if ship == nil 
      redirect_to :controller => 'ships', :action => 'new'
      return
    end
    science = @science_instance.science
    lvl = @science_instance.level
    if @science_instance.level_cap_reached
      redirect_to :back, alert: 'Forschung abgebrochen! Limit erreicht.'
      return
    end
    
    first_instance = BuildList.find_by(typeSign: 'r', instance_id: @science_instance.id)
    if first_instance != nil
      dummylists = BuildList.where(typeSign: 'n', instance_id: @science_instance.id)
      dummycount = 0
      if (dummylists!= nil)
        dummycount = dummylists.count
      end
      if(dummycount >= @science_instance.user.science_instances.find_by(:science_id => 4008).level)
        redirect_to :back, alert: 'Forschung abgebrochen! Schon am Forschen.'
        return
      else
        @science_instance.research_amount += ship.ships_stations.find_by(:station_id => 2004).level
        @science_instance.save
        BuildList.create(typeSign: 'n', ship_id: current_user.activeShip, instance_id: @science_instance.id)
      end
    else
      if(ship.metal < science.get_metal_cost(lvl) || ship.cristal < science.get_crystal_cost(lvl) || ship.fuel < science.get_fuel_cost(lvl))
        redirect_to :back, alert: 'Forschung abgebrochen! Nicht genug Ressourcen.'
        return
      else
        ship.metal -= science.get_metal_cost(lvl)
        ship.cristal -= science.get_crystal_cost(lvl)
        ship.fuel -= science.get_fuel_cost(lvl)
        ship.save
        @science_instance.research_amount = ship.ships_stations.find_by(:station_id => 2004).level
        @science_instance.save
        BuildList.create(typeSign: 'r', ship_id: current_user.activeShip, instance_id: @science_instance.id)
      end
    end
    
    redirect_to :back
  end

  def cancel_research
    currentLevel = @science_instance.level
    science = @science_instance.science

    ratio = @science_instance.get_research_ratio
    reMetal = science.get_metal_cost_ratio(currentLevel, ratio)
    reCrystal = science.get_crystal_cost_ratio(currentLevel, ratio)
    reFuel = science.get_fuel_cost_ratio(currentLevel, ratio)

    if not(@science_instance.research_ship.nil?)
      current_user.add_resources(reMetal, reCrystal, reFuel, Ship.find_by(:id => @science_instance.research_ship))
    end

    @science_instance.reset_build
    redirect_to :back
  end



  def instant_research
    if @science_instance.start_time != nil
      @science_instance.level = @science_instance.level + 1
      @science_instance.save
    end
    @science_instance.reset_build
    redirect_to :back
  end

  # PATCH/PUT /science_instances/1
  # PATCH/PUT /science_instances/1.json
  def update
    respond_to do |format|
      if @science_instance.update(science_instance_params)
        format.html { redirect_to @science_instance, notice: 'Science instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @science_instance }
      else
        format.html { render :edit }
        format.json { render json: @science_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /science_instances/1
  # DELETE /science_instances/1.json
  def destroy
    @science_instance.destroy
    respond_to do |format|
      format.html { redirect_to science_instances_url, notice: 'Science instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_science_instance
      @science_instance = ScienceInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def science_instance_params
      params.require(:science_instance).permit(:science_id, :user_id, :level, :start_time)
    end
end

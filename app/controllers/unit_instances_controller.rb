class UnitInstancesController < ApplicationController
  before_action :set_unit_instance, only: [:build, :instant_build, :cancel_build, :show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /unit_instances
  # GET /unit_instances.json
  def index
    if current_user.activeShip == nil 
      redirect_to :controller => 'ships', :action => 'new'
      return
    end
    @unit_instances = UnitInstance.all
  end

  # GET /unit_instances/1
  # GET /unit_instances/1.json
  def show
  end

  # GET /unit_instances/new
  def new
    @unit_instance = UnitInstance.new
  end

  # GET /unit_instances/1/edit
  def edit
  end

  def build
    p = params[:create_amount].to_i
    if p <= 0
      p = 1
    end
    s = current_user.active_ship
    if s == nil 
      redirect_to :controller => 'ships', :action => 'new'
      return
    end

    unit = @unit_instance.unit
    if(s.metal < unit.get_metal_cost_ratio(p) || s.cristal < unit.get_crystal_cost_ratio(p) || s.fuel < unit.get_fuel_cost_ratio(p))
      redirect_to :back, alert: 'Bauauftrag abgebrochen! Nicht genug Ressourcen.'
      return
    else
    s.metal -= unit.get_metal_cost_ratio(p)
    s.cristal -= unit.get_crystal_cost_ratio(p)
    s.fuel -= unit.get_fuel_cost_ratio(p)
    s.save
    end
    if BuildList.find_by(typeSign: 'u', ship_id: @unit_instance.ship.id, instance_id: @unit_instance.id) != nil
      @unit_instance.build_amount += p
      @unit_instance.save
    else
      @unit_instance.build_amount = p
      @unit_instance.save
      BuildList.create(typeSign: 'u', ship_id: @unit_instance.ship.id, instance_id: @unit_instance.id)
    end
    redirect_to :back
  end

  def cancel_build
    unit = @unit_instance.unit
    amount = @unit_instance.build_amount

    ratio = @unit_instance.get_ratio
    reMetal = unit.get_metal_cost_ratio(ratio + amount - 1)
    reCrystal = unit.get_crystal_cost_ratio(ratio + amount - 1) 
    reFuel = unit.get_fuel_cost_ratio(ratio + amount - 1)

    current_user.add_resources(reMetal, reCrystal, reFuel, @unit_instance.ship)

    @unit_instance.reset_build
    redirect_to :back
  end

  def instant_build
    @unit_instance.count = @unit_instance.count + (@unit_instance.build_amount || 0)
    @unit_instance.save
    @unit_instance.reset_build
    redirect_to :back
  end

  # POST /unit_instances
  # POST /unit_instances.json
  def create
    @unit_instance = UnitInstance.new(unit_instance_params)

    respond_to do |format|
      if @unit_instance.save
        format.html { redirect_to @unit_instance, notice: 'Unit instance was successfully created.' }
        format.json { render :show, status: :created, location: @unit_instance }
      else
        format.html { render :new }
        format.json { render json: @unit_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_instances/1
  # PATCH/PUT /unit_instances/1.json
  def update
    respond_to do |format|
      if @unit_instance.update(unit_instance_params)
        format.html { redirect_to @unit_instance, notice: 'Unit instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit_instance }
      else
        format.html { render :edit }
        format.json { render json: @unit_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_instances/1
  # DELETE /unit_instances/1.json
  def destroy
    @unit_instance.destroy
    respond_to do |format|
      format.html { redirect_to unit_instances_url, notice: 'Unit instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_instance
      @unit_instance = UnitInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_instance_params
      params.require(:unit_instance).permit(:unit_id, :ship_id, :amount)
    end
end

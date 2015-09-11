class UnitInstancesController < ApplicationController
  before_action :set_unit_instance, only: [:instant_build, :cancel_build, :show, :edit, :update, :destroy]

  # GET /unit_instances
  # GET /unit_instances.json
  def index
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

  def cancel_build
    if not (@unit_instance.start_time.nil?)
      unit = @unit_instance.unit
      amount = @unit_instance.build_amount

      ratio = @unit_instance.get_unit_ratio
      reMetal = unit.get_metal_cost_ratio(ratio) * amount
      reCrystal = unit.get_crystal_cost_ratio(ratio) * amount
      reFuel = unit.get_fuel_cost_ratio(ratio) * amount

      if not(@unit_instance.ship.nil?)
        current_user.add_resources(reMetal, reCrystal, reFuel, @unit_instance.ship)
      end

      @unit_instance.start_time = nil
      @unit_instance.build_amount = nil;
      @unit_instance.save
      redirect_to units_url
    end
  end

  def instant_build
    if not (@unit_instance.start_time.nil?)
      @unit_instance.start_time = nil
      
      amount = @unit_instance.build_amount
      @unit_instance.amount = @unit_instance.amount + amount
      @unit_instance.build_amount = nil

      @unit_instance.save
      redirect_to units_url
    end
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

class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :build, :edit, :update, :destroy]

  # GET /units
  # GET /units.json
  def index
    @units = Unit.all
  end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  def build
    ship = Ship.find_by(:id => params[:ship_id])
    instance = ship.get_unit_instance(Unit.find_by(:id => params[:unit_id]))
    unit = instance.unit

    if not (params[:amount].nil? || params[:amount] == 0)
      amount = params[:amount].to_i

      metal = unit.get_metal_cost()* amount
      crystal = unit.get_crystal_cost() * amount
      fuel = unit.get_fuel_cost() * amount
      current_user.remove_resources_from_current_ship(metal, crystal, fuel)

      instance.start_time = Time.now
      instance.build_amount = params[:amount].to_i

      instance.save
    end
    redirect_to units_url
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url, notice: 'Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:condition_id, :name, :metal_price, :crystal_price, :fuel_price, :shell, :damage, :damage_type_id, :cargo, :speed)
    end
end

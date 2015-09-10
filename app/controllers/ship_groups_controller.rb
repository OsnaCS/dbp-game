class ShipGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ship_group, only: [:show, :edit, :update, :destroy]
  
  
  

  # GET /ship_groups
  # GET /ship_groups.json
  def index
    @ship_groups = ShipGroup.all
  end

  # GET /ship_groups/1
  # GET /ship_groups/1.json
  def show
  end

  # GET /ship_groups/new
  def new
    @ship_group = ShipGroup.new
    
    end
    
  end

  # GET /ship_groups/1/edit
  def edit
  end

  # POST /ship_groups
  # POST /ship_groups.json
  def create
    @max_ships=50  
    @ship_group = ShipGroup.new(ship_group_params)
    @ship_name =Unit.find(@ship_group.unit_id).name
    respond_to do |format|
      if @ship_group.save
        format.html { redirect_to @ship_group, notice: 'Ship group was successfully created.' }
        format.json { render :show, status: :created, location: @ship_group }
      else
        format.html { render :new }
        format.json { render json: @ship_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ship_groups/1
  # PATCH/PUT /ship_groups/1.json
  def update
    respond_to do |format|
      if @ship_group.update(ship_group_params)
        format.html { redirect_to @ship_group, notice: 'Ship group was successfully updated.' }
        format.json { render :show, status: :ok, location: @ship_group }
      else
        format.html { render :edit }
        format.json { render json: @ship_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ship_groups/1
  # DELETE /ship_groups/1.json
  def destroy
    @ship_group.destroy
    respond_to do |format|
      format.html { redirect_to ship_groups_url, notice: 'Ship group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship_group
      @ship_group = ShipGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_group_params
      params.require(:ship_group).permit(:fighting_fleet_id, :ship_id, :number, :group_hitpoints, :unit_name)
    end
end

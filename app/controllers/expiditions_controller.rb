class ExpiditionsController < ApplicationController
  before_action :set_expidition, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /expiditions
  # GET /expiditions.json
  def index
    if(current_user.activeShip == nil)
      redirect_to :controller => 'ships', :action => 'new'
    end
    @expiditions = Expidition.all
  end

  # GET /expiditions/1
  # GET /expiditions/1.json
  def show
  end

  # GET /expiditions/new
  def new
    @expidition = Expidition.new
    @units = Unit.all
  end

  # GET /expiditions/1/edit
  def edit
  end

  # POST /expiditions
  # POST /expiditions.json
  def create
    @expidition = Expidition.new(expidition_params)

    @expidition.explore_time = params[:exp_time].to_i
    @expidition.arrival_time = Time.now + 3600 * (@expidition.explore_time + 2)
    
    ships = Hash.new(0)
    Unit.all.each do |unit|
      ships[unit.name] = params[unit.id]
    end

    @expidition.create_fleet(ships)
    if(@expiditon.fighting_fleet.ship_groups.find_by_name("Expeditionsschiff").number < 1)
      format.html{ render :new}
      format.json{ render json: @expiditions.errors, status: :unprocessable_entity }
    end

    respond_to do |format|
      if @expidition.save
        format.html { redirect_to @expidition, notice: 'Expidition was successfully created.' }
        format.json { render :show, status: :created, location: @expidition }
      else
        format.html { render :new }
        format.json { render json: @expidition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expiditions/1
  # PATCH/PUT /expiditions/1.json
  def update
    respond_to do |format|
      if @expidition.update(expidition_params)
        format.html { redirect_to @expidition, notice: 'Expidition was successfully updated.' }
        format.json { render :show, status: :ok, location: @expidition }
      else
        format.html { render :edit }
        format.json { render json: @expidition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expiditions/1
  # DELETE /expiditions/1.json
  def destroy
    @expidition.destroy
    respond_to do |format|
      format.html { redirect_to expiditions_url, notice: 'Expidition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expidition
      @expidition = Expidition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expidition_params
      params[:expidition]
    end
end

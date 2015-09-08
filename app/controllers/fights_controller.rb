class FightsController < ApplicationController
  before_action :set_fight, only: [:show, :edit, :update, :destroy]
  
  
  # GET /fights
  # GET /fights.json
  def index
    @fights = Fight.all
  end

  # GET /fights/1
  # GET /fights/1.json
  def show
  end

  # GET /fights/new
  def new
    @fight = Fight.new
    
    @units = Unit.all 
    @fleet = FightingFleet.new
    

  #  @fight.report = Fight.report(@fight.attacker_id, @fight.defender_id)
  end

  # GET /fights/1/edit
  def edit
    @fight.report = @fight.report_start
    @units = Unit.all

  end

  # POST /fights
  # POST /fights.json
  def create
    @units = Unit.all 
    @fight = Fight.new(fight_params)
    @fighting_fleet = Fight.fighting_fleet.new(fighting_fleet_params)
    @ship_groups = ShipGroup.new(ship_group_params)
    @fleet_id=fighting_fleet.id
    @fight.fighting_fleet_id=@fleet_id
   
    #@fleet = FightingFleet.new(fighting_fleet_params)
    respond_to do |format|
      @fight.report = @fight.report_start
      if @fight.save
        format.html { redirect_to @fight, notice: 'Fight was successfully created.' }
        format.json { render :show, status: :created, location: @fight }
      else
        format.html { render :new }
        format.json { render json: @fight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fights/1
  # PATCH/PUT /fights/1.json
  def update
    @fight.report = @fight.report_start
    respond_to do |format|
      if @fight.update(fight_params)
        format.html { redirect_to @fight, notice: 'Fight was successfully updated.' }
        format.json { render :show, status: :ok, location: @fight }
      else
        format.html { render :edit }
        format.json { render json: @fight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fights/1
  # DELETE /fights/1.json
  def destroy
    @fight.destroy
    respond_to do |format|
      format.html { redirect_to fights_url, notice: 'Fight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fight
      @fight = Fight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fight_params
      params.require(:fight).permit(:report, :time, :attacker_id, :defender_id)
    end
end

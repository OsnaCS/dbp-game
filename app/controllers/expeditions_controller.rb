class ExpeditionsController < ApplicationController
  before_action :set_expedition, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /expeditions
  # GET /expeditions.json
  def index
    if(current_user.activeShip == nil)
      redirect_to :controller => 'ships', :action => 'new'
    end
    @expeditions = current_user.expedition_instances.map(&:expedition)
  end

  # GET /expeditions/1
  # GET /expeditions/1.json
  def show
  end

  # GET /expeditions/new
  def new
    @expedition = Expedition.new
  end

  # GET /expeditions/1/edit
  def edit
  end

  # POST /expeditions
  # POST /expeditions.json
  def create
    @expedition = Expedition.new(expedition_params)

    @expedition.explore_time = params[:exp_time].to_i
    @expedition.arrival_time = Time.now + 3600 * (@expedition.explore_time + 2)

    if(params[Unit.find_by_name("Expeditionsschiff").id.to_s].to_i < 1)
      redirect_to expeditions_url, alert: 'Mindestens 1 Expeditionsschiff wird benötigt.'
      return
    end

    @expedition.fighting_fleet= FightingFleet.create(user: current_user)
    Unit.all.each do |unit|
      ship_group = @expedition.fighting_fleet.ship_groups.find_by(:unit_id => unit.id)
      ship_group.number = params[unit.id.to_s].to_i
      ship_group.save
    end


    respond_to do |format|
      if @expedition.save
        ExpeditionInstance.create(user: current_user, expedition_id: @expedition.id)
        format.html { redirect_to @expedition, notice: 'Expedition was successfully created.' }
        format.json { render :show, status: :created, location: @expedition }
      else
        format.html { render :new }
        format.json { render json: @expedition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expeditions/1
  # PATCH/PUT /expeditions/1.json
  def update
    respond_to do |format|
      if @expedition.update(expedition_params)
        format.html { redirect_to @expedition, notice: 'Expedition was successfully updated.' }
        format.json { render :show, status: :ok, location: @expedition }
      else
        format.html { render :edit }
        format.json { render json: @expedition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expeditions/1
  # DELETE /expeditions/1.json
  def destroy
    @expedition.destroy
    respond_to do |format|
      format.html { redirect_to expeditions_url, notice: 'Expedition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expedition
      @expedition = Expedition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expedition_params
      params[:expedition]
    end
end

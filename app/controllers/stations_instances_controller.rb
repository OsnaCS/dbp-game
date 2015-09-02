class StationsInstancesController < ApplicationController
  before_action :set_stations_instance, only: [:show, :edit, :update, :destroy]

  # GET /stations_instances
  # GET /stations_instances.json
  def index
    @stations_instances = StationsInstance.all
  end

  # GET /stations_instances/1
  # GET /stations_instances/1.json
  def show
  end

  # GET /stations_instances/new
  def new
    @stations_instance = StationsInstance.new
  end

  # GET /stations_instances/1/edit
  def edit
  end

  # POST /stations_instances
  # POST /stations_instances.json
  def create
    @stations_instance = StationsInstance.new(stations_instance_params)

    respond_to do |format|
      if @stations_instance.save
        format.html { redirect_to @stations_instance, notice: 'Stations instance was successfully created.' }
        format.json { render :show, status: :created, location: @stations_instance }
      else
        format.html { render :new }
        format.json { render json: @stations_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stations_instances/1
  # PATCH/PUT /stations_instances/1.json
  def update
    respond_to do |format|
      if @stations_instance.update(stations_instance_params)
        format.html { redirect_to @stations_instance, notice: 'Stations instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @stations_instance }
      else
        format.html { render :edit }
        format.json { render json: @stations_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations_instances/1
  # DELETE /stations_instances/1.json
  def destroy
    @stations_instance.destroy
    respond_to do |format|
      format.html { redirect_to stations_instances_url, notice: 'Stations instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stations_instance
      @stations_instance = StationsInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stations_instance_params
      params.require(:stations_instance).permit(:shipID, :statID, :level)
    end
end

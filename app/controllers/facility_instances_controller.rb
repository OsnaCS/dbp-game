class FacilityInstancesController < ApplicationController
  before_action :set_facility_instance, only: [:show, :edit, :update, :destroy, :build, :cancel_build, :instant_build, :check_conditions]
  before_action :authenticate_user!

  # GET /facility_instances
  # GET /facility_instances.json
  def index
    if current_user.activeShip == nil 
      redirect_to :controller => 'ships', :action => 'new'
      return
    end
    @facility_instances = FacilityInstance.all
  end

  # GET /facility_instances/1
  # GET /facility_instances/1.json
  def show
  end

  # GET /facility_instances/new
  def new
    @facility_instance = FacilityInstance.new
  end

  # GET /facility_instances/1/edit
  def edit
  end

  # POST /facility_instances
  # POST /facility_instances.json
  def create
    @facility_instance = FacilityInstance.new(facility_instance_params)

    respond_to do |format|
      if @facility_instance.save
        format.html { redirect_to @facility_instance, notice: 'Facility instance was successfully created.' }
        format.json { render :show, status: :created, location: @facility_instance }
      else
        format.html { render :new }
        format.json { render json: @facility_instance.errors, status: :unprocessable_entity }
      end
    end
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
    resourcefactor = 500
    f = @facility_instance.facility
    if(s.metal < p * f.cost1 * resourcefactor || s.cristal < p * f.cost2 * resourcefactor || s.fuel < p * f.cost3 * resourcefactor)
      redirect_to facilities_url, alert: 'Build was cancelled! Not enough resources.'
      return
    else
    s.metal -= p * f.cost1 * resourcefactor
    s.cristal -= p * f.cost2 * resourcefactor
    s.fuel -= p * f.cost3 * resourcefactor
    s.save
    end
    @facility_instance.start_time = Time.now
    @facility_instance.create_count = p
    @facility_instance.save

    redirect_to facilities_url
  end

  def cancel_build
    @facility_instance.start_time = nil
    @facility_instance.create_count = nil
    @facility_instance.save
    redirect_to facilities_url
  end

  def instant_build
    @facility_instance.count = @facility_instance.count + (@facility_instance.create_count || 0)
    @facility_instance.start_time = nil
    @facility_instance.create_count = nil
    @facility_instance.save
    redirect_to facilities_url
  end

  # PATCH/PUT /facility_instances/1
  # PATCH/PUT /facility_instances/1.json
  def update
    respond_to do |format|
      if @facility_instance.update(facility_instance_params)
        format.html { redirect_to @facility_instance, notice: 'Facility instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @facility_instance }
      else
        format.html { render :edit }
        format.json { render json: @facility_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_instances/1
  # DELETE /facility_instances/1.json
  def destroy
    @facility_instance.destroy
    respond_to do |format|
      format.html { redirect_to facility_instances_url, notice: 'Facility instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_instance
      @facility_instance = FacilityInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_instance_params
      params.require(:facility_instance).permit(:facility_id, :ship_id, :count, :create_count, :start_time)
    end
end

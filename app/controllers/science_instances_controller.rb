class ScienceInstancesController < ApplicationController
  before_action :set_science_instance, only: [:show, :edit, :update, :destroy]

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

class ExpeditionInstancesController < ApplicationController
  before_action :set_expedition_instance, only: [:show, :edit, :update, :destroy]

  # GET /expedition_instances
  # GET /expedition_instances.json
  def index
    @expedition_instances = ExpeditionInstance.all
  end

  # GET /expedition_instances/1
  # GET /expedition_instances/1.json
  def show
  end

  # GET /expedition_instances/new
  def new
    @expedition_instance = ExpeditionInstance.new
  end

  # GET /expedition_instances/1/edit
  def edit
  end

  # POST /expedition_instances
  # POST /expedition_instances.json
  def create
    @expedition_instance = ExpeditionInstance.new(expedition_instance_params)

    respond_to do |format|
      if @expedition_instance.save
        format.html { redirect_to @expedition_instance, notice: 'Expedition instance was successfully created.' }
        format.json { render :show, status: :created, location: @expedition_instance }
      else
        format.html { render :new }
        format.json { render json: @expedition_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expedition_instances/1
  # PATCH/PUT /expedition_instances/1.json
  def update
    respond_to do |format|
      if @expedition_instance.update(expedition_instance_params)
        format.html { redirect_to @expedition_instance, notice: 'Expedition instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @expedition_instance }
      else
        format.html { render :edit }
        format.json { render json: @expedition_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expedition_instances/1
  # DELETE /expedition_instances/1.json
  def destroy
    @expedition_instance.destroy
    respond_to do |format|
      format.html { redirect_to expedition_instances_url, notice: 'Expedition instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expedition_instance
      @expedition_instance = ExpeditionInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expedition_instance_params
      params.require(:expedition_instance).permit(:user_id, :expedition_id)
    end
end

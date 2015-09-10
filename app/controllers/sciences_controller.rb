class SciencesController < ApplicationController
  before_action :set_science, only: [:show, :edit, :update, :destroy]

  before_filter :check_login

  def check_login
    unless current_user
      redirect_to "/users/sign_in/"
    end
  end
  
  # GET /sciences
  # GET /sciences.json
  def index
    @sciences = Science.all
  end

  # GET /sciences/1
  # GET /sciences/1.json
  def show
  end

  # GET /sciences/new
  def new
    @science = Science.new
  end

  # GET /sciences/1/edit
  def edit
  end

  # POST /sciences
  # POST /sciences.json
  def create
    @science = Science.new(science_params)

    respond_to do |format|
      if @science.save
        format.html { redirect_to @science, notice: 'Science was successfully created.' }
        format.json { render :show, status: :created, location: @science }
      else
        format.html { render :new }
        format.json { render json: @science.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sciences/1
  # PATCH/PUT /sciences/1.json
  def update
    respond_to do |format|
      if @science.update(science_params)
        format.html { redirect_to @science, notice: 'Science was successfully updated.' }
        format.json { render :show, status: :ok, location: @science }
      else
        format.html { render :edit }
        format.json { render json: @science.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sciences/1
  # DELETE /sciences/1.json
  def destroy
    @science.destroy
    respond_to do |format|
      format.html { redirect_to sciences_url, notice: 'Science was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_science
      @science = Science.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def science_params
      params.require(:science).permit(:cost1, :cost2, :cost3, :factor, :duration, :condition, :name, :tier, :science_condition_id, :icon, :level_cap)
    end
end

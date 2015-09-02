class StationtypesController < ApplicationController
  before_action :set_stationtype, only: [:show, :edit, :update, :destroy]

  # GET /stationtypes
  # GET /stationtypes.json
  def index
    @stationtypes = Stationtype.all
  end

  # GET /stationtypes/1
  # GET /stationtypes/1.json
  def show
  end

  # GET /stationtypes/new
  def new
    @stationtype = Stationtype.new
  end

  # GET /stationtypes/1/edit
  def edit
  end

  # POST /stationtypes
  # POST /stationtypes.json
  def create
    @stationtype = Stationtype.new(stationtype_params)

    respond_to do |format|
      if @stationtype.save
        format.html { redirect_to @stationtype, notice: 'Stationtype was successfully created.' }
        format.json { render :show, status: :created, location: @stationtype }
      else
        format.html { render :new }
        format.json { render json: @stationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stationtypes/1
  # PATCH/PUT /stationtypes/1.json
  def update
    respond_to do |format|
      if @stationtype.update(stationtype_params)
        format.html { redirect_to @stationtype, notice: 'Stationtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @stationtype }
      else
        format.html { render :edit }
        format.json { render json: @stationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stationtypes/1
  # DELETE /stationtypes/1.json
  def destroy
    @stationtype.destroy
    respond_to do |format|
      format.html { redirect_to stationtypes_url, notice: 'Stationtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stationtype
      @stationtype = Stationtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stationtype_params
      params.require(:stationtype).permit(:statID, :name, :costMineral, :costCristal, :costFuel)
    end
end
